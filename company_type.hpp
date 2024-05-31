#pragma once

#include "company_group.hpp"

struct company_type
{
    static const constexpr auto table() { return "company_type"; }
    static const constexpr auto primary_key() { return &company_type::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct group_id
    {
        static const constexpr auto c_name() { return "group_id"; }
        int32_t value;
        static const constexpr auto foreign_key() { return &company_group::id; }
    } group_id;

    struct type_name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value;
    } type_name;

    struct notes
    {
        static const constexpr auto c_name() { return "notes"; }
        std::string value;
    } notes;

    struct risk_score
    {
        static const constexpr auto c_name() { return "risk_score"; }
        int8_t value;
    } risk_score;
};
