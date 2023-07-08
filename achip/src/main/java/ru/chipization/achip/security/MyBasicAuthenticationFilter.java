package ru.chipization.achip.security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import ru.chipization.achip.security.service.UserService;

import javax.validation.constraints.NotNull;
import java.io.IOException;
import java.util.Base64;

@Component
public class MyBasicAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private UserService userService;

    @Override
    protected void doFilterInternal(@NotNull HttpServletRequest request,
                                    @NotNull HttpServletResponse response,
                                    @NotNull jakarta.servlet.FilterChain filterChain
    ) throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        final String authHeader = request.getHeader("Authorization");
        final String email;
        final String password;
        // Здесь пройдёт только неавторизованный пользователь с запросами GET
        if(authHeader == null || !authHeader.startsWith("Basic ")) {
            filterChain.doFilter(request, response);

            return;
        }

        // Если пришёл запрос на регистрацию от авторизованного ползователя
        // Здесь пройдёт только авторизованный пользователь
        if((SecurityContextHolder.getContext().getAuthentication() != null && request.getRequestURI().equals("/registration")) ||
                (request.getRequestURI().equals("/registration") && (authHeader != null || authHeader.startsWith("Basic ")))) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            resp.getOutputStream().println("You are already logged in");
            resp.getOutputStream().close();

            return;
        }

        String base64LoginAndPassword = authHeader.split(" ")[1];
        byte[] bytesLoginAndPassword = Base64.getDecoder().decode(base64LoginAndPassword);
        String loginAndPassword = new String(bytesLoginAndPassword);

        email = loginAndPassword.split(":")[0];
        password = loginAndPassword.split(":")[1];

        // Если email не пустой и пользователь не авторизирован
        // Здесь пройдёт только неавторизованный пользователь
        if(email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            // Проверка по логину
            // Здесь пройдёт только существующий логин
            UserDetails userDetails;
            try {
                userDetails = this.userService.loadUserByUsername(email);
            } catch (UsernameNotFoundException unfe) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getOutputStream().println("Invalid authorization data");
                resp.getOutputStream().close();

                return;
            }

            // Проверка по паролю
            // Здесь пройдёт только существующий пароль для текущего логина
            if(new BCryptPasswordEncoder().matches(password, userDetails.getPassword())) {
                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                        userDetails,
                        null,
                        userDetails.getAuthorities()
                );

                authToken.setDetails(
                        new WebAuthenticationDetailsSource().buildDetails(request)
                );

                SecurityContextHolder.getContext().setAuthentication(authToken);
            } else {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getOutputStream().println("Invalid authorization data");
                resp.getOutputStream().close();

                return;
            }
        }

        filterChain.doFilter(request, response);
    }
}
