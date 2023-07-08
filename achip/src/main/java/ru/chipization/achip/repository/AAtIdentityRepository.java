package ru.chipization.achip.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.chipization.achip.model.AAtIdentity;
import ru.chipization.achip.model.Animal;
import ru.chipization.achip.model.AnimalType;

import java.util.List;
import java.util.Optional;

public interface AAtIdentityRepository extends JpaRepository<AAtIdentity, Long> {
    Optional<List<AAtIdentity>> findAAtIdentitiesByIdAnimal(Animal animal);
    Optional<AAtIdentity> findAAtIdentitiesByIdAnimalAndAndIdAnimalType(Animal animal, AnimalType animalType);
}
