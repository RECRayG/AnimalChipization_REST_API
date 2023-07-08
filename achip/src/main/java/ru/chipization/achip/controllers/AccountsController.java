package ru.chipization.achip.controllers;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import ru.chipization.achip.dto.request.RegisterRequest;
import ru.chipization.achip.dto.response.UserResponse;
import ru.chipization.achip.dto.search.UserSearchQuery;
import ru.chipization.achip.dto.search.Request;
import ru.chipization.achip.dto.search.SearchRequest;
import ru.chipization.achip.exception.AlreadyExistException;
import ru.chipization.achip.model.Animal;
import ru.chipization.achip.model.User;
import ru.chipization.achip.repository.AnimalRepository;
import ru.chipization.achip.repository.UserRepository;
import ru.chipization.achip.service.FilterSpecification;
import ru.chipization.achip.service.OffsetBasedPageRequest;

import java.util.ArrayList;
import java.util.Optional;
import java.util.List;
import java.util.regex.Pattern;

@RestController
@CrossOrigin("*")
@RequestMapping("/accounts")
@AllArgsConstructor
public class AccountsController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AnimalRepository animalRepository;

    @Autowired
    private FilterSpecification<User> filterSpecification;

    @Autowired
    private final PasswordEncoder passwordEncoder;

    private static final String EMAIL_PATTERN =
            "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
                    "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

    @GetMapping("/{accountId}")
    public ResponseEntity<?> getAccountById(@PathVariable Integer accountId) {
        if(accountId == null || accountId <= 0) {
            return ResponseEntity.status(400).body("Id: " + accountId + " is not correct");
        }

        Optional<User> userCheck = userRepository.findById(Long.valueOf(accountId));
        if(userCheck.isEmpty()) {
            return ResponseEntity.status(404).body("User with id: " + accountId + " not found");
        }

        User user = userCheck.get();

        return new ResponseEntity<UserResponse>(UserResponse.builder()
                                .id(user.getId().intValue())
                                .firstName(user.getFirstName())
                                .lastName(user.getLastName())
                                .email(user.getEmail())
                                .build(),
                                HttpStatus.OK);
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchAccounts(@ModelAttribute UserSearchQuery userSearchQuery//,
                                            /*@RequestParam("from") Integer from,*/
                                            /*@RequestParam("size") Integer size*/) {
        if(userSearchQuery.getFrom() == null) {
            userSearchQuery.setFrom(0);
        }
        if(userSearchQuery.getSize() == null) {
            userSearchQuery.setSize(10);
        }
        if(userSearchQuery.getFrom() < 0) {
            return ResponseEntity.status(400).body("Count of \'from\': " + userSearchQuery.getFrom() + " is not correct");
        }
        if(userSearchQuery.getSize() <= 0) {
            return ResponseEntity.status(400).body("Count of \'size\': " + userSearchQuery.getSize() + " is not correct");
        }

        Request request = new Request(new ArrayList<>());
        Pageable pageable = new OffsetBasedPageRequest(
                userSearchQuery.getFrom() != null && userSearchQuery.getFrom() > 0 ? userSearchQuery.getFrom() : 0,
                userSearchQuery.getSize() != null && userSearchQuery.getSize() > 0 ? userSearchQuery.getSize() : 10);

        if(userSearchQuery.getFirstName() != null) {
            request.getSearchRequest().add(new SearchRequest("firstName", userSearchQuery.getFirstName()));
        }
        if(userSearchQuery.getLastName() != null) {
            request.getSearchRequest().add(new SearchRequest("lastName", userSearchQuery.getLastName()));
        }
        if(userSearchQuery.getEmail() != null) {
            request.getSearchRequest().add(new SearchRequest("email", userSearchQuery.getEmail()));
        }

        Specification<User> searchSpecification = filterSpecification
                .getSearchSpecification(request.getSearchRequest());


        List<User> users = userRepository.findAll(searchSpecification, pageable).getContent();
        List<UserResponse> userResponses = new ArrayList<>();
        users.forEach(user -> {
            userResponses.add(UserResponse.builder()
                            .id(user.getId().intValue())
                            .firstName(user.getFirstName())
                            .lastName(user.getLastName())
                            .email(user.getEmail())
                            .build());
        });


        return ResponseEntity.status(200).body(userResponses);
    }

    @PutMapping("/{accountId}")
    public ResponseEntity<?> updateAccount(@PathVariable Integer accountId, @RequestBody RegisterRequest updateData) {
        // Проверка на 400 - валидность данных
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        if(accountId == null || accountId <= 0 ||
            updateData.getFirstName() == null || updateData.getFirstName().trim().equals("") ||
            updateData.getLastName() == null || updateData.getLastName().trim().equals("") ||
            updateData.getEmail() == null || updateData.getEmail().trim().equals("") || !pattern.matcher(updateData.getEmail()).matches() ||
            updateData.getPassword() == null || updateData.getPassword().trim().equals("")) {

            return ResponseEntity.status(400).body("Not valid data");
        }

        // Проверка на 403 - существование аккаунта
        Optional<User> userCheck = userRepository.findById(Long.valueOf(accountId));
        if(userCheck.isEmpty()) {
            return ResponseEntity.status(403).body("Account with id: " + accountId + " is not found");
        }
        User user = userCheck.get();

        // Проверка на 403 - обновление не своего аккаунта
        User userUpdateCheck = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(userUpdateCheck.getId() != user.getId()) {
            return ResponseEntity.status(403).body("Update not your account");
        }

        // Проверка на 409 - email уже существует
        List<User> userList = userRepository.findAll();
        try {
            userList.forEach(us -> {
                if(us.getEmail().equals(updateData.getEmail()) && !user.getId().equals(us.getId())) {
                    throw new AlreadyExistException("User with email: " + updateData.getEmail() + " already exist");
                }
            });
        } catch(AlreadyExistException eae) {
            return ResponseEntity.status(409).body(eae.getMessage());
        }

        user.setFirstName(updateData.getFirstName());
        user.setLastName(updateData.getLastName());
        user.setEmail(updateData.getEmail());
        user.setPassword(passwordEncoder.encode(updateData.getPassword()));

        userRepository.save(user);

        return ResponseEntity.status(200).body(UserResponse.builder()
                                                .id(user.getId().intValue())
                                                .firstName(user.getFirstName())
                                                .lastName(user.getLastName())
                                                .email(user.getEmail())
                                                .build());
    }

    @DeleteMapping("/{accountId}")
    public ResponseEntity<?> deleteAccount(@PathVariable Integer accountId) {
        // Проверка на 400 - валидность данных
        if(accountId == null || accountId <= 0) {
            return ResponseEntity.status(400).body("Id: " + accountId + " is not correct");
        }

        // Проверка на 403 - существование аккаунта
        Optional<User> userCheck = userRepository.findById(Long.valueOf(accountId));
        if(userCheck.isEmpty()) {
            return ResponseEntity.status(403).body("Account with id: " + accountId + " is not found");
        }
        User user = userCheck.get();

        // Проверка на 403 - удаление не своего аккаунта
        User userUpdateCheck = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(userUpdateCheck.getId() != user.getId()) {
            return ResponseEntity.status(403).body("Delete not your account");
        }

        // Проверка на 400 - связь аккаунта с животными
//        List<Animal> animalsCheck = animalRepository.findAnimalsByIdChipper(user).get();
        if(!user.getAnimalCollection().isEmpty()) {
            return ResponseEntity.status(400).body("Account associated with animals");
        } else {
            userRepository.delete(user);
            return ResponseEntity.status(200).body("Successful removal");
        }
    }

    @GetMapping("/")
    public ResponseEntity<?> getAccountIdEmpty() {
        return ResponseEntity.status(400).body("Id is null");
    }

    @PutMapping("/")
    public ResponseEntity<?> updateAccountEmpty() {
        return ResponseEntity.status(400).body("Id is null");
    }

    @DeleteMapping("/")
    public ResponseEntity<?> deleteAccountEmpty() {
        return ResponseEntity.status(400).body("Id is null");
    }
}
