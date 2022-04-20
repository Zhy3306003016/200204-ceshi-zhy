package com.zhy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("page")
public class ViewController {
    @RequestMapping("index")
    public Object index(){

        return "index";
    }
}
