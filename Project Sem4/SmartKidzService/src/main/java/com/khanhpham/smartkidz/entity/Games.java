/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.khanhpham.smartkidz.entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author inmac
 */
@Entity
@Table(name = "games")
public class Games implements Serializable {

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
    @Column(name = "description")
    private String description;

    @Lob
    @Column(name = "image")
    private String image;

    @Lob
    @Column(name = "BGM")
    private String bgm;

    @Basic(optional = false)
    @Column(name = "is_active")
    private boolean isActive;

    // @JsonManagedReference
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "gameId")
    private Collection<Score> scoreCollection;

    // @JsonManagedReference
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "gameId")
    private Collection<Difficulties> difficultiesCollection;

    // @JsonManagedReference
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "gameId")
    private Collection<Topics> topicsCollection;

    public Games() {
    }

    public Games(Integer id) {
        this.id = id;
    }

    public Games(Integer id, String name, boolean isActive) {
        this.id = id;
        this.name = name;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBgm() {
        return bgm;
    }

    public void setBgm(String bgm) {
        this.bgm = bgm;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    @XmlTransient
    public Collection<Score> getScoreCollection() {
        return scoreCollection;
    }

    public void setScoreCollection(Collection<Score> scoreCollection) {
        this.scoreCollection = scoreCollection;
    }

    @XmlTransient
    public Collection<Difficulties> getDifficultiesCollection() {
        return difficultiesCollection;
    }

    public void setDifficultiesCollection(Collection<Difficulties> difficultiesCollection) {
        this.difficultiesCollection = difficultiesCollection;
    }

    @XmlTransient
    public Collection<Topics> getTopicsCollection() {
        return topicsCollection;
    }

    public void setTopicsCollection(Collection<Topics> topicsCollection) {
        this.topicsCollection = topicsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Games)) {
            return false;
        }
        Games other = (Games) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.khanhpham.smartkidz.entity.Games[ id=" + id + " ]";
    }

}
