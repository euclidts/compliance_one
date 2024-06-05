#pragma once

#include <cstdint>
#include <string>

struct user
{
    static consteval auto table() { return "user"; }
    static consteval auto primary_key() { return &user::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct username
    {
        static consteval auto c_name() { return "username"; }
        std::string value;
    } username;

    struct password
    {
        static consteval auto c_name() { return "password"; }
        std::string value;
        // static consteval auto permission() { enum p { write }; return p; }
    } password;
    
    enum clearances
    {
        business_user,
        compliance_user,
        manager,
        admin
    };

    struct clearance
    {
        static consteval auto c_name() { return "clearance"; }
        clearances value;
    } clearance;

    struct session_id
    {
        static consteval auto c_name() { return "session_id"; }
        std::string value;
    } session_id;
};
