/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.khanhpham.smartkidz.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author inmac
 */

@Entity
@Table(name = "game_details")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class GameDetails implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @Column(name = "game_id")
    private int gameId;

    @Column(name = "difficulty_id")
    private Integer difficultyId;

    @Column(name = "points")
    private Integer points;

    @Column(name = "topic_id")
    private Integer topicId;

    @Lob
    @Column(name = "question")
    private String question;

    @Lob
    @Column(name = "image")
    private String image;

    @Column(name = "answer_one")
    private String answerOne;

    @Column(name = "answer_two")
    private String answerTwo;

    @Column(name = "answer_three")
    private String answerThree;

    @Column(name = "answer_four")
    private String answerFour;

    @Column(name = "correct_answer")
    private String correctAnswer;
    @Basic(optional = false)

    @Column(name = "is_active")
    private boolean isActive;
    @Basic(optional = false)

    @Column(name = "created_at")
    @CreationTimestamp
    private Date createdAt;
    @Basic(optional = false)

    @Column(name = "updated_at")
    @UpdateTimestamp
    private Date updatedAt;

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof GameDetails)) {
            return false;
        }
        GameDetails other = (GameDetails) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.khanhpham.smartkidz.entity.GameDetails[ id=" + id + " ]";
    }

}
