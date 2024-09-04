package com.entasdfs.common.apidocs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/docs/")
@Controller
public class ServingDocsController {

    @GetMapping("/swagger")
    public String toSwaggerIndex() {
        return "redirect:/docs/swagger/index.html";
    }
}
