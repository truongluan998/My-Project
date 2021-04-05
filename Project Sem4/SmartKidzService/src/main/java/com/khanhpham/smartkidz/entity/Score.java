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
import javax.persistence.FetchType;
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
@Table(name = "score")
public class Score implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @Column(name = "score")
    private int score;

    @JsonBackReference("userScore")
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Users userId;

    @JsonBackReference("gameScore")
    @JoinColumn(name = "game_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Games gameId;

    public Score() {
    }

    public Score(Integer id) {
        this.id = id;
    }

    public Score(Integer id, int score) {
        this.id = id;
        this.score = score;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
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
        if (!(object instanceof Score)) {
            return false;
        }
        Score other = (Score) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.khanhpham.smartkidz.entity.Score[ id=" + id + " ]";
    }

}
