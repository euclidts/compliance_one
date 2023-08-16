struct restriction
{
    struct person_sanctions
    {
        static const constexpr auto c_name() { return "person_sanctions"; };
        static const constexpr auto name() { return "Person"; };
        sovereignties value{none};
    } person_sanctions;

    // restriction foreign table
};
