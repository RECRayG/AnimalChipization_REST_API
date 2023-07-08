package ru.chipization.achip.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import ru.chipization.achip.model.Animal;
import ru.chipization.achip.model.User;

import java.util.Optional;
import java.util.List;
@Repository
public interface UserRepository extends JpaRepository<User,Long>, JpaSpecificationExecutor<User> {
    Optional<User> findByEmail(String email);
//    Page<User> findAll(Specification<User> spec, Pageable pagable, Sort sort);
//    List<User> findAllIgnoreCase(Specification<User> userSpecification);
//    List<User> searchUsers(String query);
}
