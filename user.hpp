#include <cstdint>
#include <string>

struct user
{
    static const constexpr auto table() { return "user"; }

    struct primary_key
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } primary_key;

    struct username
    {
        static const constexpr auto c_name() { return "username"; }
        std::string value{};
    } username;

    struct password
    {
        static const constexpr auto c_name() { return "password"; }
        std::string value{};
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
        clearances value{business_user};
    } clearance;

    struct session_id
    {
        static const constexpr auto c_name() { return "session_id"; }
        std::string value{};
    } session_id;
};
