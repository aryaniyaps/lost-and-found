package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {
    
    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/items")
    public String items() {
        return "items";
    }

    @GetMapping("/items/new")
    public String newItem() {
        return "item-form";
    }

    @GetMapping("/complaints")
    public String complaints() {
        return "complaints";
    }

    @GetMapping("/complaints/new")
    public String newComplaint() {
        return "complaint-form";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/items/{id}")
    public String itemDetail() {
        return "item-detail";
    }
}
