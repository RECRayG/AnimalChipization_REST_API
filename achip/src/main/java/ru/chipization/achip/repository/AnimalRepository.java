package ru.chipization.achip.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import ru.chipization.achip.model.Animal;
import ru.chipization.achip.model.User;

import java.util.List;
import java.util.Optional;

public interface AnimalRepository extends JpaRepository<Animal,Long>, JpaSpecificationExecutor<Animal> {
    Optional<List<Animal>> findAnimalsByIdChipper(User idChipper);
}
