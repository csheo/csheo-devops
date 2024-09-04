package com.entasdfs.domain.order.presentation;

import org.springframework.web.bind.annotation.*;



import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/order/multi-currency-price")
public class OrderMultiCurrencyPriceController {


    @GetMapping("/hello")
    public String hello(){

        return "HI";
    }



}
