package com.smartparking.smartbrain.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;

@Component
public class LoggingFilter extends OncePerRequestFilter {
    private static final Logger logger = LoggerFactory.getLogger(LoggingFilter.class);

    @Override
    protected void doFilterInternal(@SuppressWarnings("null") HttpServletRequest request, @SuppressWarnings("null") HttpServletResponse response, 
                                    @SuppressWarnings("null") FilterChain filterChain) throws ServletException, IOException {
        long startTime = System.currentTimeMillis();
        
        // Log thông tin request
        logger.info("REQUEST [{} {}] - Headers: {}", request.getMethod(), request.getRequestURI(), request.getHeaderNames());

        filterChain.doFilter(request, response);

        // Log thông tin response
        long duration = System.currentTimeMillis() - startTime;
        logger.info("RESPONSE [{} {}] - Status: {}, Time Taken: {}ms", request.getMethod(), request.getRequestURI(), response.getStatus(), duration);
    }
}
