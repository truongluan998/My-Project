/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.khanhpham.smartkidz.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlTransient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 *
 * @author inmac
 */
@Entity
@Table(name = "levels")
public class Levels implements Serializable {

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
    @Column(name = "required_level_score")
    private int requiredLevelScore;

    @Lob
    @Column(name = "icon")
    private String icon;

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

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "levelId")
    private Collection<Users> usersCollection;

    public Levels() {
    }

    public Levels(Integer id) {
        this.id = id;
    }

    public Levels(Integer id, String name, int requiredLevelScore, boolean isActive, Date createdAt, Date updatedAt) {
        this.id = id;
        this.name = name;
        this.requiredLevelScore = requiredLevelScore;
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

    public int getRequiredLevelScore() {
        return requiredLevelScore;
    }

    public void setRequiredLevelScore(int requiredLevelScore) {
        this.requiredLevelScore = requiredLevelScore;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
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

    @XmlTransient
    public Collection<Users> getUsersCollection() {
        return usersCollection;
    }

    public void setUsersCollection(Collection<Users> usersCollection) {
        this.usersCollection = usersCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Levels)) {
            return false;
        }
        Levels other = (Levels) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.khanhpham.smartkidz.entity.Levels[ id=" + id + " ]";
    }

}
