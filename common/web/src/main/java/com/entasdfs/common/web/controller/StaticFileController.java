package com.entasdfs.common.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class StaticFileController {

    @GetMapping("favicon.ico")
    public void noFavicon() {
    }
}
