package com.khanhpham.smartkidz.repository;

import java.util.List;

import com.khanhpham.smartkidz.entity.GameDetails;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface GamesDetailsRepository extends PagingAndSortingRepository<GameDetails, Integer> {

    @Query("Select g from GameDetails g where g.gameId=:gameId and g.topicId=:topicId order by rand()")
    List<GameDetails> findByGameIdAndTopicIdLimited(@Param("gameId") int gameId, @Param("topicId") int topicId,
            Pageable pageable);

    @Query("Select g.correctAnswer from GameDetails g WHERE g.question LIKE :question order by rand()")
    List<String> findAnswers(@Param("question") String question, Pageable pageable);

    @Query("Select g.correctAnswer from GameDetails g WHERE g.correctAnswer LIKE :question order by rand()")
    List<String> findAnswersByStartLetter(@Param("question") String question, Pageable pageable);

    @Query("Select g from GameDetails g where g.gameId=:gameId and g.topicId=:topicId and g.difficultyId=:difficultyId")
    List<GameDetails> findByGameIdAndTopicIdAndDiff(@Param("gameId") int gameId, @Param("topicId") int topicId,
            @Param("difficultyId") int difficultyId);

    @Query("Select g from GameDetails g where g.gameId=:gameId and g.topicId=:topicId and g.isActive = true")
    List<GameDetails> findByGameIdAndTopicId(@Param("gameId") int gameId, @Param("topicId") int topicId);

    @Query("Select g from GameDetails g where g.gameId=:gameId and g.topicId=:topicId and g.isActive = false")
    List<GameDetails> findByGameIdAndTopicIdInactive(@Param("gameId") int gameId, @Param("topicId") int topicId);

    @Query("Select g from GameDetails g where g.gameId=:gameId and g.isActive = true")
    List<GameDetails> findByGameId(@Param("gameId") int gameId);

    @Query("Select g from GameDetails g where g.gameId=:gameId and g.isActive = false")
    List<GameDetails> findByGameIdInactive(@Param("gameId") int gameId);

    @Query("Select g from GameDetails g where g.isActive = false")
    List<GameDetails> findGameByInactive();

    @Query("Select g from GameDetails g where g.isActive = true")
    List<GameDetails> findAll();

}
