---------------------------------------------------------------------------
-- CHERI state components
-- (c) Alexandre Joannou, University of Cambridge
---------------------------------------------------------------------------

type CapRegFile = reg -> Capability

register CapCause :: bits (16)
{
    15-8 : ExcCode  -- 8 bits exception code
     7-0 : RegNum   -- 8 bits register number
}

declare
{
   -- State of all cores
   all_BranchDelayPCC:: id -> (bits(64) * Capability) option
   all_BranchToPCC   :: id -> (bits(64) * Capability) option
   all_capcause      :: id -> CapCause    -- capability exception cause register
   all_pcc           :: id -> Capability  -- program counter capability
   all_capr          :: id -> CapRegFile  -- capability register file

   -- State of current core
   BranchDelayPCC    :: (bits(64) * Capability) option
   BranchToPCC       :: (bits(64) * Capability) option
   capcause          :: CapCause          -- capability exception cause register
   c_pcc             :: Capability        -- program counter capability
   c_capr            :: CapRegFile        -- capability register file
}

unit switchCoreCAP (i::id) =
{
   all_BranchDelayPCC (procID) <- BranchDelayPCC;
   all_BranchToPCC (procID) <- BranchToPCC;
   all_capcause (procID) <- capcause;
   all_pcc (procID) <- c_pcc;
   all_capr (procID) <- c_capr;
   BranchDelayPCC <- all_BranchDelayPCC (i);
   BranchToPCC <- all_BranchToPCC (i);
   capcause <- all_capcause (i);
   c_pcc <- all_pcc (i);
   c_capr <- all_capr (i)
}

unit dumpCRegs () =
{
    mark_log (0, "======   Registers   ======")
  ; mark_log (0, "Core = " : [[procID]::nat])
  ; mark_log (0, "DEBUG CAP PCC   \t" : log_cap_write(all_pcc(procID)))
  ; m = all_capr(procID)
  ; for i in 0 .. 31 do
    mark_log (0, "DEBUG CAP REG " :
        (if i<10 then " " else "") : [[i]::nat] :
        "\t" : log_cap_write(m([i])))
}

component PCC :: Capability
{
    value = c_pcc
    assign value =
    {
        c_pcc <- value;
        mark_log (2, log_cpp_write (value))
    }
}

component CAPR (n::reg) :: Capability
{
    value = c_capr(n)
    assign value =
    {
        c_capr(n) <- value;
        mark_log (2, log_creg_write (n, value))
    }
}

component RCC :: Capability
{
    value = CAPR(24)
    assign value = CAPR(24) <- value
}

component IDC :: Capability
{
    value = CAPR(26)
    assign value = CAPR(26) <- value
}

component KR1C :: Capability
{
    value = CAPR(27)
    assign value = CAPR(27) <- value
}

component KR2C :: Capability
{
    value = CAPR(28)
    assign value = CAPR(28) <- value
}

component KCC :: Capability
{
    value = CAPR(29)
    assign value = CAPR(29) <- value
}

component KDC :: Capability
{
    value = CAPR(30)
    assign value = CAPR(30) <- value
}

component EPCC :: Capability
{
    value = CAPR(31)
    assign value = CAPR(31) <- value
}
