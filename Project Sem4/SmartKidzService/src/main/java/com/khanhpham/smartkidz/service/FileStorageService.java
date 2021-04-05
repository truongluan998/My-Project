package com.khanhpham.smartkidz.service;

import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public interface FileStorageService {

    String storeFile(MultipartFile file, String username);

    Resource loadFileAsResource(String fileName);

}
