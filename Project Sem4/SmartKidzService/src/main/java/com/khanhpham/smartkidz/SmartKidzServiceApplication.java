package com.khanhpham.smartkidz;

import com.khanhpham.smartkidz.Utils.FileStorageProperties;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties({ FileStorageProperties.class })
public class SmartKidzServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(SmartKidzServiceApplication.class, args);
	}

}
