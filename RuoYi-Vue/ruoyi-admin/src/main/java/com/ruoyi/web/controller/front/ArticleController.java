package com.ruoyi.web.controller.front;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.lee.domain.LeeArticle;
import com.ruoyi.lee.service.ILeeArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.ruoyi.common.utils.PageUtils.startPage;

@RestController
@RequestMapping("/front/article")
public class ArticleController extends BaseController {
    @Autowired
    private ILeeArticleService leeArticleService;

    @GetMapping("/list")
    public TableDataInfo list(LeeArticle leeArticle) {
        startPage();
        List<LeeArticle> list = leeArticleService.selectFrontLeeArticleList(leeArticle);
        return getDataTable(list);
    }
}
