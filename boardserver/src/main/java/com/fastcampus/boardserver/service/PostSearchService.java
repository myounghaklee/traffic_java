package com.fastcampus.boardserver.service;

import com.fastcampus.boardserver.dto.PostDTO;
import com.fastcampus.boardserver.dto.request.PostSearchRequest;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.scheduling.annotation.Async;

import java.util.List;

public interface PostSearchService {

    @Async
    @Cacheable(value = "getProducts", key = "'getProducts' + #postSearchRequest.getName() + #postSearchRequest.getCategoryId()")
    List<PostDTO> getProducts(PostSearchRequest postSearchRequest);

    List<PostDTO> getPosts(PostSearchRequest postSearchRequest);

    List<PostDTO> getPostByTag(String tagName);
}