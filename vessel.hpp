#pragma once

#include <cstdint>
#include <string>

#include "company.hpp"

struct vessel
{
    static const constexpr auto table() { return "vessel"; }
    static const constexpr auto primary_key() { return &vessel::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    // KYC 
    // Vessel information
    // accesible to all users

    struct vessel_name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value{};
    } vessel_name;

    struct imo
    {
        static const constexpr auto c_name() { return "imo"; }
        // static const constexpr auto name() { return "IMO"; }
        std::string value{};
    } imo;

    struct owner_id
    {
        static const constexpr auto c_name() { return "owner_id"; }
        int32_t value{};
        static const constexpr auto references() { return &company::id; }
    } owner_id;

    struct manager_id
    {
        static const constexpr auto c_name() { return "manager_id"; }
        int32_t value{};
        static const constexpr auto references() { return &company::id; }
    } manager_id;

    // restrictions Flag
};
