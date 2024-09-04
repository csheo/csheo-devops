package com.entasdfs.common.commoncode.api.controller;


import org.springframework.web.bind.annotation.*;

import lombok.RequiredArgsConstructor;

@RequestMapping("/operation/internal/common-codes")
@RequiredArgsConstructor
@RestController
public class CommonCodeController {

    @GetMapping("/hello")
    public String hello(){


        return "HI";
    }

}
