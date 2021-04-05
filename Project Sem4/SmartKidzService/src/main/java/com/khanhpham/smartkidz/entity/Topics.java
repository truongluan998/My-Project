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
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 *
 * @author inmac
 */
@Entity
@Table(name = "topics")
public class Topics implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @Column(name = "name")
    private String name;

    @Lob
    @Column(name = "image")
    private String image;

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

    @JsonBackReference("gameTopic")
    @JoinColumn(name = "game_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Games gameId;

    public Topics() {
    }

    public Topics(Integer id) {
        this.id = id;
    }

    public Topics(Integer id, String name, boolean isActive, Date createdAt, Date updatedAt) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
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
        if (!(object instanceof Topics)) {
            return false;
        }
        Topics other = (Topics) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.khanhpham.smartkidz.entity.Topics[ id=" + id + " ]";
    }

}
