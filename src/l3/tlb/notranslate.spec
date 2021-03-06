---------------------------------------------------------------------------
-- MIPS TLB address translation
-- (c) Anthony Fox, University of Cambridge
-- (c) Alexandre Joannou, University of Cambridge
---------------------------------------------------------------------------

pAddr * CCA AddressTranslation (vAddr::vAddr, IorD::IorD, AccessType::AccessType) =
{
    unmapped, valid = CheckSegment (vAddr);
    if valid then
        match unmapped
        {
            case Some (addr, cca) =>
            {
                check_cca(cca);
                ([addr], cca)
            }
            case _ => ([vAddr], 0)
        }
    else
    {
        CP0.BadVAddr <- vAddr;
        SignalException (if AccessType == LOAD then AdEL else AdES);
        UNKNOWN
    }
}

pAddr option tlbTryTranslation (vAddr::vAddr) = None

TLBEntry CP0TLBEntry () = UNKNOWN
