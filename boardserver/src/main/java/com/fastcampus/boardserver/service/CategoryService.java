package com.fastcampus.boardserver.service;

import com.fastcampus.boardserver.dto.CategoryDTO;

public interface CategoryService {
    void regist(String accountId, CategoryDTO categoryDTO);
}
