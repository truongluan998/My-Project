/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.khanhpham.smartkidz.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 *
 * @author inmac
 */
@Entity
@Table(name = "difficulties")
public class Difficulties implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @Column(name = "required_score")
    private int requiredScore;
    @Basic(optional = false)
    @Column(name = "time_limit")
    private int timeLimit;
    @Basic(optional = false)
    @Column(name = "total_time_play")
    private int totalTimePlay;
    @Basic(optional = false)
    @Column(name = "total_question")
    private int totalQuestion;
    @Basic(optional = false)
    @Column(name = "is_active")
    private boolean isActive;

    @JsonBackReference("gameDiff")
    @JoinColumn(name = "game_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Games gameId;

    public Difficulties() {
    }

    public Difficulties(Integer id) {
        this.id = id;
    }

    public Difficulties(Integer id, String name, int requiredScore, int timeLimit, int totalTimePlay, int totalQuestion,
            boolean isActive) {
        this.id = id;
        this.name = name;
        this.requiredScore = requiredScore;
        this.timeLimit = timeLimit;
        this.totalTimePlay = totalTimePlay;
        this.totalQuestion = totalQuestion;
        this.isActive = isActive;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRequiredScore() {
        return requiredScore;
    }

    public void setRequiredScore(int requiredScore) {
        this.requiredScore = requiredScore;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(int timeLimit) {
        this.timeLimit = timeLimit;
    }

    public int getTotalTimePlay() {
        return totalTimePlay;
    }

    public void setTotalTimePlay(int totalTimePlay) {
        this.totalTimePlay = totalTimePlay;
    }

    public int getTotalQuestion() {
        return totalQuestion;
    }

    public void setTotalQuestion(int totalQuestion) {
        this.totalQuestion = totalQuestion;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Games getGameId() {
        return gameId;
    }

    public void setGameId(Games gameId) {
        this.gameId = gameId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Difficulties)) {
            return false;
        }
        Difficulties other = (Difficulties) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.khanhpham.smartkidz.entity.Difficulties[ id=" + id + " ]";
    }

}
