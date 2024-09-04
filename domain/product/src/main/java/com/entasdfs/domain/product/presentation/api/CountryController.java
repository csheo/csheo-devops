package com.entasdfs.domain.product.presentation.api;


import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/template")
@RestController
public class CountryController {

    @GetMapping("/hello")
    public String hello(){

        return "HI";
    }


}
