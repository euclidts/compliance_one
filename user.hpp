#pragma once

#include <cstdint>
#include <string>

struct user
{
    static const constexpr auto table() { return "user"; }
    static const constexpr auto primary_key() { return &user::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct username
    {
        static const constexpr auto c_name() { return "username"; }
        std::string value;
    } username;

    struct password
    {
        static const constexpr auto c_name() { return "password"; }
        std::string value;
        // static const constexpr auto permission() { enum p { write }; return p; }
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
        static const constexpr auto c_name() { return "clearance"; }
        clearances value;
    } clearance;

    struct session_id
    {
        static const constexpr auto c_name() { return "session_id"; }
        std::string value;
    } session_id;
};
