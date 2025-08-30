package com.ruoyi.lee.service;

import com.ruoyi.lee.domain.LeeUniqueView;

import java.util.List;

public interface ILeeUVService {

    public void view(String ip);

    public List<LeeUniqueView> recordView();
}
