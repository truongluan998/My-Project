package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.GamesDetailDto;
import com.khanhpham.smartkidz.entity.GameDetails;

public class GameDetailsMapper {

	public static GamesDetailDto toGameDetailsDto(GameDetails gameDetails) {
		GamesDetailDto gdd = new GamesDetailDto();
		gdd.setId(gameDetails.getId());
		gdd.setQuestion(gameDetails.getQuestion());
		gdd.setImage(gameDetails.getImage());
		gdd.setCorrectAnswer(gameDetails.getCorrectAnswer());
		gdd.setAnswerOne(gameDetails.getAnswerOne());
		gdd.setAnswerTwo(gameDetails.getAnswerTwo());
		gdd.setAnswerThree(gameDetails.getAnswerThree());
		gdd.setAnswerFour(gameDetails.getAnswerFour());
		gdd.setIsActive(Status.find(gameDetails.isActive()));
		gdd.setGameId(gameDetails.getGameId());
		gdd.setDifficultyId(gameDetails.getDifficultyId());
		if (gameDetails.getPoints() != null)
			gdd.setPoints(gameDetails.getPoints());
		gdd.setTopicId(gameDetails.getTopicId());

		return gdd;
	}

	public static GameDetails fromGameDetailsDto(GamesDetailDto g) {
		GameDetails fdd = new GameDetails();
		fdd.setId(g.getId());
		fdd.setQuestion(g.getQuestion());
		fdd.setImage(g.getImage());
		fdd.setAnswerOne(g.getAnswerOne());
		fdd.setAnswerTwo(g.getAnswerTwo());
		fdd.setAnswerThree(g.getAnswerThree());
		fdd.setAnswerFour(g.getAnswerFour());
		fdd.setCorrectAnswer(g.getCorrectAnswer());
		fdd.setActive(g.getIsActive().value);
		fdd.setGameId(g.getGameId());
		fdd.setDifficultyId(g.getDifficultyId());
		fdd.setPoints(g.getPoints());
		fdd.setTopicId(g.getTopicId());
		return fdd;
	}
}
