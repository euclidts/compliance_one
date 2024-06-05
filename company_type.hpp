#pragma once

#include "company_group.hpp"

struct company_type
{
    static consteval auto table() { return "company_type"; }
    static consteval auto primary_key() { return &company_type::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct group_id
    {
        static consteval auto c_name() { return "group_id"; }
        int32_t value;
        static consteval auto foreign_key() { return &company_group::id; }
    } group_id;

    struct type_name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
    } type_name;

    struct notes
    {
        static consteval auto c_name() { return "notes"; }
        std::string value;
    } notes;

    struct risk_score
    {
        static consteval auto c_name() { return "risk_score"; }
        int8_t value;
    } risk_score;
};
