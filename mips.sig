(* mips - generated by L<3> - Fri Jul 04 10:18:53 2014 *)

signature mips =
sig

structure Map: MutableMap

(* -------------------------------------------------------------------------
   Types
   ------------------------------------------------------------------------- *)

type Index = { Index: BitsN.nbit, P: bool, index'rst: BitsN.nbit }

type Random = { Random: BitsN.nbit, random'rst: BitsN.nbit }

type Wired = { Wired: BitsN.nbit, wired'rst: BitsN.nbit }

type EntryLo =
  { C: BitsN.nbit, D: bool, G: bool, PFN: BitsN.nbit, V: bool,
    entrylo'rst: BitsN.nbit }

type PageMask = { Mask: BitsN.nbit, pagemask'rst: BitsN.nbit }

type EntryHi =
  { ASID: BitsN.nbit, R: BitsN.nbit, VPN2: BitsN.nbit,
    entryhi'rst: BitsN.nbit }

type StatusRegister =
  { BEV: bool, CU0: bool, ERL: bool, EXL: bool, FR: bool, IE: bool,
    IM: BitsN.nbit, KSU: BitsN.nbit, KX: bool, RE: bool, SX: bool,
    UX: bool, statusregister'rst: BitsN.nbit }

type ConfigRegister =
  { BE: bool, K0: BitsN.nbit, MT: BitsN.nbit,
    configregister'rst: BitsN.nbit }

type CauseRegister =
  { BD: bool, ExcCode: BitsN.nbit, IP: BitsN.nbit, TI: bool,
    causeregister'rst: BitsN.nbit }

type XContext =
  { BadVPN2: BitsN.nbit, R: BitsN.nbit, xcontext'rst: BitsN.nbit }

type CP0 =
  { BadVAddr: BitsN.nbit, Cause: CauseRegister, Compare: BitsN.nbit,
    Config: ConfigRegister, Count: BitsN.nbit, Debug: BitsN.nbit,
    EPC: BitsN.nbit, EntryHi: EntryHi, EntryLo0: EntryLo,
    EntryLo1: EntryLo, ErrCtl: BitsN.nbit, ErrorEPC: BitsN.nbit,
    Index: Index, LLAddr: BitsN.nbit, PRId: BitsN.nbit,
    PageMask: PageMask, Random: Random, Status: StatusRegister,
    Wired: Wired, XContext: XContext }

datatype ExceptionType =
    Int | Mod | TLBL | TLBS | AdEL | AdES | Sys | Bp | ResI | CpU | Ov
  | Tr | XTLBRefill

datatype IorD = INSTRUCTION | DATA

datatype LorS = LOAD | STORE

type JTAG_UART_data =
  { RAVAIL: BitsN.nbit, RVALID: bool, RW_DATA: BitsN.nbit,
    jtag_uart_data'rst: BitsN.nbit }

type JTAG_UART_control =
  { AC: bool, RE: bool, RI: bool, WE: bool, WI: bool, WSPACE: BitsN.nbit,
    jtag_uart_control'rst: BitsN.nbit }

type JTAG_UART =
  { base_address: BitsN.nbit, control: JTAG_UART_control,
    data: JTAG_UART_data, read_fifo: BitsN.nbit list,
    read_threshold: Nat.nat, write_fifo: BitsN.nbit list,
    write_threshold: Nat.nat }

datatype event =
    w_c0 of BitsN.nbit * BitsN.nbit
  | w_gpr of BitsN.nbit * BitsN.nbit
  | w_hi of BitsN.nbit
  | w_lo of BitsN.nbit
  | w_mem of BitsN.nbit * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))

type TLBEntry =
  { ASID: BitsN.nbit, C0: BitsN.nbit, C1: BitsN.nbit, D0: bool, D1: bool,
    G: bool, Mask: BitsN.nbit, PFN0: BitsN.nbit, PFN1: BitsN.nbit,
    R: BitsN.nbit, V0: bool, V1: bool, VPN2: BitsN.nbit }

datatype Branch =
    BEQ of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | BEQL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | BGEZ of BitsN.nbit * BitsN.nbit
  | BGEZAL of BitsN.nbit * BitsN.nbit
  | BGEZALL of BitsN.nbit * BitsN.nbit
  | BGEZL of BitsN.nbit * BitsN.nbit
  | BGTZ of BitsN.nbit * BitsN.nbit
  | BGTZL of BitsN.nbit * BitsN.nbit
  | BLEZ of BitsN.nbit * BitsN.nbit
  | BLEZL of BitsN.nbit * BitsN.nbit
  | BLTZ of BitsN.nbit * BitsN.nbit
  | BLTZAL of BitsN.nbit * BitsN.nbit
  | BLTZALL of BitsN.nbit * BitsN.nbit
  | BLTZL of BitsN.nbit * BitsN.nbit
  | BNE of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | BNEL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | J of BitsN.nbit
  | JAL of BitsN.nbit
  | JALR of BitsN.nbit * BitsN.nbit
  | JR of BitsN.nbit

datatype CP =
    DMFC0 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DMTC0 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | MFC0 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | MTC0 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)

datatype Store =
    SB of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SC of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SCD of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SD of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SDL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SDR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SH of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SW of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SWL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SWR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)

datatype Load =
    LB of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LBU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LD of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LDL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LDR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LH of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LHU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LLD of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LW of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LWL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LWR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LWU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)

datatype Trap =
    TEQ of BitsN.nbit * BitsN.nbit
  | TEQI of BitsN.nbit * BitsN.nbit
  | TGE of BitsN.nbit * BitsN.nbit
  | TGEI of BitsN.nbit * BitsN.nbit
  | TGEIU of BitsN.nbit * BitsN.nbit
  | TGEU of BitsN.nbit * BitsN.nbit
  | TLT of BitsN.nbit * BitsN.nbit
  | TLTI of BitsN.nbit * BitsN.nbit
  | TLTIU of BitsN.nbit * BitsN.nbit
  | TLTU of BitsN.nbit * BitsN.nbit
  | TNE of BitsN.nbit * BitsN.nbit
  | TNEI of BitsN.nbit * BitsN.nbit

datatype Shift =
    DSLL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSLL32 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSLLV of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSRA of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSRA32 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSRAV of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSRL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSRL32 of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSRLV of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SLL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SLLV of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SRA of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SRAV of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SRL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SRLV of BitsN.nbit * (BitsN.nbit * BitsN.nbit)

datatype MultDiv =
    DDIV of BitsN.nbit * BitsN.nbit
  | DDIVU of BitsN.nbit * BitsN.nbit
  | DIV of BitsN.nbit * BitsN.nbit
  | DIVU of BitsN.nbit * BitsN.nbit
  | DMULT of BitsN.nbit * BitsN.nbit
  | DMULTU of BitsN.nbit * BitsN.nbit
  | MADD of BitsN.nbit * BitsN.nbit
  | MADDU of BitsN.nbit * BitsN.nbit
  | MFHI of BitsN.nbit
  | MFLO of BitsN.nbit
  | MSUB of BitsN.nbit * BitsN.nbit
  | MSUBU of BitsN.nbit * BitsN.nbit
  | MTHI of BitsN.nbit
  | MTLO of BitsN.nbit
  | MUL of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | MULT of BitsN.nbit * BitsN.nbit
  | MULTU of BitsN.nbit * BitsN.nbit

datatype ArithR =
    ADD of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | ADDU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | AND of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DADD of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DADDU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSUB of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DSUBU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | MOVN of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | MOVZ of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | NOR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | OR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SLT of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SLTU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SUB of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SUBU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | XOR of BitsN.nbit * (BitsN.nbit * BitsN.nbit)

datatype ArithI =
    ADDI of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | ADDIU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | ANDI of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DADDI of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | DADDIU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | LUI of BitsN.nbit * BitsN.nbit
  | ORI of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SLTI of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | SLTIU of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | XORI of BitsN.nbit * (BitsN.nbit * BitsN.nbit)

datatype instruction =
    ArithI of ArithI
  | ArithR of ArithR
  | BREAK
  | Branch of Branch
  | CACHE of BitsN.nbit * (BitsN.nbit * BitsN.nbit)
  | CP of CP
  | ERET
  | Load of Load
  | MultDiv of MultDiv
  | ReservedInstruction
  | SYNC of BitsN.nbit
  | SYSCALL
  | Shift of Shift
  | Store of Store
  | TLBP
  | TLBR
  | TLBWI
  | TLBWR
  | Trap of Trap

(* -------------------------------------------------------------------------
   Exceptions
   ------------------------------------------------------------------------- *)

exception UNPREDICTABLE of string

(* -------------------------------------------------------------------------
   Functions
   ------------------------------------------------------------------------- *)

structure Cast:
sig

val natToExceptionType:Nat.nat -> ExceptionType
val ExceptionTypeToNat:ExceptionType-> Nat.nat
val stringToExceptionType:string -> ExceptionType
val ExceptionTypeToString:ExceptionType-> string
val natToIorD:Nat.nat -> IorD
val IorDToNat:IorD-> Nat.nat
val stringToIorD:string -> IorD
val IorDToString:IorD-> string
val natToLorS:Nat.nat -> LorS
val LorSToNat:LorS-> Nat.nat
val stringToLorS:string -> LorS
val LorSToString:LorS-> string

end

val BranchDelay: (BitsN.nbit option) ref
val BranchTo: (BitsN.nbit option) ref
val CP0: CP0 ref
val JTAG_UART: JTAG_UART ref
val LLbit: (bool option) ref
val MEM: (BitsN.nbit Map.map) ref
val PC: BitsN.nbit ref
val TLB_assoc: (TLBEntry Map.map) ref
val TLB_direct: (TLBEntry Map.map) ref
val exceptionSignalled: bool ref
val gpr: (BitsN.nbit Map.map) ref
val hi: (BitsN.nbit option) ref
val lo: (BitsN.nbit option) ref
val log: (event list) ref
val Index_Index_rupd: Index * BitsN.nbit -> Index
val Index_P_rupd: Index * bool -> Index
val Index_index'rst_rupd: Index * BitsN.nbit -> Index
val Random_Random_rupd: Random * BitsN.nbit -> Random
val Random_random'rst_rupd: Random * BitsN.nbit -> Random
val Wired_Wired_rupd: Wired * BitsN.nbit -> Wired
val Wired_wired'rst_rupd: Wired * BitsN.nbit -> Wired
val EntryLo_C_rupd: EntryLo * BitsN.nbit -> EntryLo
val EntryLo_D_rupd: EntryLo * bool -> EntryLo
val EntryLo_G_rupd: EntryLo * bool -> EntryLo
val EntryLo_PFN_rupd: EntryLo * BitsN.nbit -> EntryLo
val EntryLo_V_rupd: EntryLo * bool -> EntryLo
val EntryLo_entrylo'rst_rupd: EntryLo * BitsN.nbit -> EntryLo
val PageMask_Mask_rupd: PageMask * BitsN.nbit -> PageMask
val PageMask_pagemask'rst_rupd: PageMask * BitsN.nbit -> PageMask
val EntryHi_ASID_rupd: EntryHi * BitsN.nbit -> EntryHi
val EntryHi_R_rupd: EntryHi * BitsN.nbit -> EntryHi
val EntryHi_VPN2_rupd: EntryHi * BitsN.nbit -> EntryHi
val EntryHi_entryhi'rst_rupd: EntryHi * BitsN.nbit -> EntryHi
val StatusRegister_BEV_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_CU0_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_ERL_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_EXL_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_FR_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_IE_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_IM_rupd: StatusRegister * BitsN.nbit -> StatusRegister
val StatusRegister_KSU_rupd: StatusRegister * BitsN.nbit -> StatusRegister
val StatusRegister_KX_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_RE_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_SX_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_UX_rupd: StatusRegister * bool -> StatusRegister
val StatusRegister_statusregister'rst_rupd:
  StatusRegister * BitsN.nbit -> StatusRegister
val ConfigRegister_BE_rupd: ConfigRegister * bool -> ConfigRegister
val ConfigRegister_K0_rupd: ConfigRegister * BitsN.nbit -> ConfigRegister
val ConfigRegister_MT_rupd: ConfigRegister * BitsN.nbit -> ConfigRegister
val ConfigRegister_configregister'rst_rupd:
  ConfigRegister * BitsN.nbit -> ConfigRegister
val CauseRegister_BD_rupd: CauseRegister * bool -> CauseRegister
val CauseRegister_ExcCode_rupd:
  CauseRegister * BitsN.nbit -> CauseRegister
val CauseRegister_IP_rupd: CauseRegister * BitsN.nbit -> CauseRegister
val CauseRegister_TI_rupd: CauseRegister * bool -> CauseRegister
val CauseRegister_causeregister'rst_rupd:
  CauseRegister * BitsN.nbit -> CauseRegister
val XContext_BadVPN2_rupd: XContext * BitsN.nbit -> XContext
val XContext_R_rupd: XContext * BitsN.nbit -> XContext
val XContext_xcontext'rst_rupd: XContext * BitsN.nbit -> XContext
val CP0_BadVAddr_rupd: CP0 * BitsN.nbit -> CP0
val CP0_Cause_rupd: CP0 * CauseRegister -> CP0
val CP0_Compare_rupd: CP0 * BitsN.nbit -> CP0
val CP0_Config_rupd: CP0 * ConfigRegister -> CP0
val CP0_Count_rupd: CP0 * BitsN.nbit -> CP0
val CP0_Debug_rupd: CP0 * BitsN.nbit -> CP0
val CP0_EPC_rupd: CP0 * BitsN.nbit -> CP0
val CP0_EntryHi_rupd: CP0 * EntryHi -> CP0
val CP0_EntryLo0_rupd: CP0 * EntryLo -> CP0
val CP0_EntryLo1_rupd: CP0 * EntryLo -> CP0
val CP0_ErrCtl_rupd: CP0 * BitsN.nbit -> CP0
val CP0_ErrorEPC_rupd: CP0 * BitsN.nbit -> CP0
val CP0_Index_rupd: CP0 * Index -> CP0
val CP0_LLAddr_rupd: CP0 * BitsN.nbit -> CP0
val CP0_PRId_rupd: CP0 * BitsN.nbit -> CP0
val CP0_PageMask_rupd: CP0 * PageMask -> CP0
val CP0_Random_rupd: CP0 * Random -> CP0
val CP0_Status_rupd: CP0 * StatusRegister -> CP0
val CP0_Wired_rupd: CP0 * Wired -> CP0
val CP0_XContext_rupd: CP0 * XContext -> CP0
val JTAG_UART_data_RAVAIL_rupd:
  JTAG_UART_data * BitsN.nbit -> JTAG_UART_data
val JTAG_UART_data_RVALID_rupd: JTAG_UART_data * bool -> JTAG_UART_data
val JTAG_UART_data_RW_DATA_rupd:
  JTAG_UART_data * BitsN.nbit -> JTAG_UART_data
val JTAG_UART_data_jtag_uart_data'rst_rupd:
  JTAG_UART_data * BitsN.nbit -> JTAG_UART_data
val JTAG_UART_control_AC_rupd:
  JTAG_UART_control * bool -> JTAG_UART_control
val JTAG_UART_control_RE_rupd:
  JTAG_UART_control * bool -> JTAG_UART_control
val JTAG_UART_control_RI_rupd:
  JTAG_UART_control * bool -> JTAG_UART_control
val JTAG_UART_control_WE_rupd:
  JTAG_UART_control * bool -> JTAG_UART_control
val JTAG_UART_control_WI_rupd:
  JTAG_UART_control * bool -> JTAG_UART_control
val JTAG_UART_control_WSPACE_rupd:
  JTAG_UART_control * BitsN.nbit -> JTAG_UART_control
val JTAG_UART_control_jtag_uart_control'rst_rupd:
  JTAG_UART_control * BitsN.nbit -> JTAG_UART_control
val JTAG_UART_base_address_rupd: JTAG_UART * BitsN.nbit -> JTAG_UART
val JTAG_UART_control_rupd: JTAG_UART * JTAG_UART_control -> JTAG_UART
val JTAG_UART_data_rupd: JTAG_UART * JTAG_UART_data -> JTAG_UART
val JTAG_UART_read_fifo_rupd: JTAG_UART * (BitsN.nbit list) -> JTAG_UART
val JTAG_UART_read_threshold_rupd: JTAG_UART * Nat.nat -> JTAG_UART
val JTAG_UART_write_fifo_rupd: JTAG_UART * (BitsN.nbit list) -> JTAG_UART
val JTAG_UART_write_threshold_rupd: JTAG_UART * Nat.nat -> JTAG_UART
val TLBEntry_ASID_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_C0_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_C1_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_D0_rupd: TLBEntry * bool -> TLBEntry
val TLBEntry_D1_rupd: TLBEntry * bool -> TLBEntry
val TLBEntry_G_rupd: TLBEntry * bool -> TLBEntry
val TLBEntry_Mask_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_PFN0_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_PFN1_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_R_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val TLBEntry_V0_rupd: TLBEntry * bool -> TLBEntry
val TLBEntry_V1_rupd: TLBEntry * bool -> TLBEntry
val TLBEntry_VPN2_rupd: TLBEntry * BitsN.nbit -> TLBEntry
val boolify'32:
  BitsN.nbit ->
  bool *
  (bool *
   (bool *
    (bool *
     (bool *
      (bool *
       (bool *
        (bool *
         (bool *
          (bool *
           (bool *
            (bool *
             (bool *
              (bool *
               (bool *
                (bool *
                 (bool *
                  (bool *
                   (bool *
                    (bool *
                     (bool *
                      (bool *
                       (bool *
                        (bool *
                         (bool *
                          (bool *
                           (bool *
                            (bool * (bool * (bool * (bool * bool))))))))))))))))))))))))))))))
val rec'Index: BitsN.nbit -> Index
val reg'Index: Index -> BitsN.nbit
val write'rec'Index: (BitsN.nbit * Index) -> BitsN.nbit
val write'reg'Index: (Index * BitsN.nbit) -> Index
val rec'Random: BitsN.nbit -> Random
val reg'Random: Random -> BitsN.nbit
val write'rec'Random: (BitsN.nbit * Random) -> BitsN.nbit
val write'reg'Random: (Random * BitsN.nbit) -> Random
val rec'Wired: BitsN.nbit -> Wired
val reg'Wired: Wired -> BitsN.nbit
val write'rec'Wired: (BitsN.nbit * Wired) -> BitsN.nbit
val write'reg'Wired: (Wired * BitsN.nbit) -> Wired
val rec'EntryLo: BitsN.nbit -> EntryLo
val reg'EntryLo: EntryLo -> BitsN.nbit
val write'rec'EntryLo: (BitsN.nbit * EntryLo) -> BitsN.nbit
val write'reg'EntryLo: (EntryLo * BitsN.nbit) -> EntryLo
val rec'PageMask: BitsN.nbit -> PageMask
val reg'PageMask: PageMask -> BitsN.nbit
val write'rec'PageMask: (BitsN.nbit * PageMask) -> BitsN.nbit
val write'reg'PageMask: (PageMask * BitsN.nbit) -> PageMask
val rec'EntryHi: BitsN.nbit -> EntryHi
val reg'EntryHi: EntryHi -> BitsN.nbit
val write'rec'EntryHi: (BitsN.nbit * EntryHi) -> BitsN.nbit
val write'reg'EntryHi: (EntryHi * BitsN.nbit) -> EntryHi
val rec'StatusRegister: BitsN.nbit -> StatusRegister
val reg'StatusRegister: StatusRegister -> BitsN.nbit
val write'rec'StatusRegister: (BitsN.nbit * StatusRegister) -> BitsN.nbit
val write'reg'StatusRegister:
  (StatusRegister * BitsN.nbit) -> StatusRegister
val rec'ConfigRegister: BitsN.nbit -> ConfigRegister
val reg'ConfigRegister: ConfigRegister -> BitsN.nbit
val write'rec'ConfigRegister: (BitsN.nbit * ConfigRegister) -> BitsN.nbit
val write'reg'ConfigRegister:
  (ConfigRegister * BitsN.nbit) -> ConfigRegister
val rec'CauseRegister: BitsN.nbit -> CauseRegister
val reg'CauseRegister: CauseRegister -> BitsN.nbit
val write'rec'CauseRegister: (BitsN.nbit * CauseRegister) -> BitsN.nbit
val write'reg'CauseRegister: (CauseRegister * BitsN.nbit) -> CauseRegister
val rec'XContext: BitsN.nbit -> XContext
val reg'XContext: XContext -> BitsN.nbit
val write'rec'XContext: (BitsN.nbit * XContext) -> BitsN.nbit
val write'reg'XContext: (XContext * BitsN.nbit) -> XContext
val ExceptionCode: ExceptionType -> unit
val SignalException: ExceptionType -> unit
val BYTE: BitsN.nbit
val HALFWORD: BitsN.nbit
val WORD: BitsN.nbit
val DOUBLEWORD: BitsN.nbit
val UserMode: unit -> bool
val SupervisorMode: unit -> bool
val KernelMode: unit -> bool
val BigEndianMem: unit -> bool
val ReverseEndian: unit -> BitsN.nbit
val BigEndianCPU: unit -> BitsN.nbit
val rec'JTAG_UART_data: BitsN.nbit -> JTAG_UART_data
val reg'JTAG_UART_data: JTAG_UART_data -> BitsN.nbit
val write'rec'JTAG_UART_data: (BitsN.nbit * JTAG_UART_data) -> BitsN.nbit
val write'reg'JTAG_UART_data:
  (JTAG_UART_data * BitsN.nbit) -> JTAG_UART_data
val rec'JTAG_UART_control: BitsN.nbit -> JTAG_UART_control
val reg'JTAG_UART_control: JTAG_UART_control -> BitsN.nbit
val write'rec'JTAG_UART_control:
  (BitsN.nbit * JTAG_UART_control) -> BitsN.nbit
val write'reg'JTAG_UART_control:
  (JTAG_UART_control * BitsN.nbit) -> JTAG_UART_control
val JTAG_UART_load: unit -> unit
val JTAG_UART_input: (BitsN.nbit list) -> unit
val JTAG_UART_store: (BitsN.nbit * BitsN.nbit) -> unit
val JTAG_UART_output: unit -> (BitsN.nbit list)
val JTAG_UART_initialise: Nat.nat -> unit
val PSIZE: Nat.nat
val mark: event -> unit
val unmark: unit -> unit
val GPR: BitsN.nbit -> BitsN.nbit
val write'GPR: (BitsN.nbit * BitsN.nbit) -> unit
val HI: unit -> BitsN.nbit
val write'HI: BitsN.nbit -> unit
val LO: unit -> BitsN.nbit
val write'LO: BitsN.nbit -> unit
val CPR: (Nat.nat * (BitsN.nbit * BitsN.nbit)) -> BitsN.nbit
val write'CPR:
  (BitsN.nbit * (Nat.nat * (BitsN.nbit * BitsN.nbit))) -> unit
val TLBEntries: Nat.nat
val LookupTLB: (BitsN.nbit * BitsN.nbit) -> ((BitsN.nbit * TLBEntry) list)
val ModifyTLB: TLBEntry -> TLBEntry
val SignalTLBException:
  (ExceptionType * (BitsN.nbit * BitsN.nbit)) -> (BitsN.nbit * BitsN.nbit)
val CheckSegment:
  BitsN.nbit -> (((BitsN.nbit * BitsN.nbit) option) * bool)
val AddressTranslation:
  (BitsN.nbit * (IorD * LorS)) -> (BitsN.nbit * BitsN.nbit)
val flip_endian: BitsN.nbit -> BitsN.nbit
val JTAG_UART_write_mm: unit -> unit
val LoadMemory:
  (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * IorD)))) ->
  BitsN.nbit
val loadWord32: BitsN.nbit -> BitsN.nbit
val StoreMemory:
  (BitsN.nbit *
   (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * IorD))))) ->
  unit
val dfn'TLBP: unit -> unit
val dfn'TLBR: unit -> unit
val dfn'TLBWI: unit -> unit
val dfn'TLBWR: unit -> unit
val dfn'CACHE: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val Fetch: unit -> (BitsN.nbit option)
val initTLB: unit -> TLBEntry
val addTLB: (BitsN.nbit * BitsN.nbit) -> unit
val initMips: (Nat.nat * Nat.nat) -> unit
val done: unit -> bool
val NotWordValue: BitsN.nbit -> bool
val dfn'ADDI: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'ADDIU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DADDI: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DADDIU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SLTI: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SLTIU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'ANDI: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'ORI: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'XORI: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LUI: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'ADD: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'ADDU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SUB: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SUBU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DADD: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DADDU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSUB: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSUBU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SLT: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SLTU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'AND: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'OR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'XOR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'NOR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'MOVN: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'MOVZ: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'MADD: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'MADDU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'MSUB: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'MSUBU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'MUL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'MULT: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'MULTU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'DMULT: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'DMULTU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'DIV: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'DIVU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'DDIV: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'DDIVU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'MFHI: BitsN.nbit -> unit
val dfn'MFLO: BitsN.nbit -> unit
val dfn'MTHI: BitsN.nbit -> unit
val dfn'MTLO: BitsN.nbit -> unit
val dfn'SLL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SRL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SRA: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SLLV: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SRLV: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SRAV: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSLL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSRL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSRA: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSLLV: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSRLV: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSRAV: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSLL32: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSRL32: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DSRA32: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'TGE: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TGEU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TLT: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TLTU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TEQ: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TNE: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TGEI: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TGEIU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TLTI: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TLTIU: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TEQI: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'TNEI: (BitsN.nbit * BitsN.nbit) -> unit
val loadByte: (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * bool))) -> unit
val loadHalf: (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * bool))) -> unit
val loadWord:
  (bool * (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * bool)))) -> unit
val loadDoubleword:
  (bool * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> unit
val dfn'LB: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LBU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LH: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LHU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LW: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LWU: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LD: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LLD: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LWL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LWR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LDL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'LDR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SB: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SH: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val storeWord: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val storeDoubleword: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SW: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SD: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SC: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SCD: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SWL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SWR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SDL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SDR: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'SYNC: BitsN.nbit -> unit
val dfn'BREAK: unit -> unit
val dfn'SYSCALL: unit -> unit
val dfn'ERET: unit -> unit
val dfn'MTC0: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DMTC0: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'MFC0: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'DMFC0: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'J: BitsN.nbit -> unit
val dfn'JAL: BitsN.nbit -> unit
val dfn'JR: BitsN.nbit -> unit
val dfn'JALR: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BEQ: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'BNE: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'BLEZ: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BGTZ: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BLTZ: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BGEZ: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BLTZAL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BGEZAL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BEQL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'BNEL: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> unit
val dfn'BLEZL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BGTZL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BLTZL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BGEZL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BLTZALL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'BGEZALL: (BitsN.nbit * BitsN.nbit) -> unit
val dfn'ReservedInstruction: unit -> unit
val Run: instruction -> unit
val Decode: BitsN.nbit -> instruction
val Next: unit -> unit
val cpr: BitsN.nbit -> string
val r: BitsN.nbit -> string
val c: BitsN.nbit -> string
val i:Nat.nat-> BitsN.nbit -> string
val oi:Nat.nat-> BitsN.nbit -> string
val op1i:Nat.nat-> (string * BitsN.nbit) -> string
val op1r: (string * BitsN.nbit) -> string
val op1ri:Nat.nat-> (string * (BitsN.nbit * BitsN.nbit)) -> string
val op2r: (string * (BitsN.nbit * BitsN.nbit)) -> string
val op2ri:Nat.nat->
  (string * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> string
val op3r: (string * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> string
val op2roi:Nat.nat->
  (string * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> string
val opmem:Nat.nat->
  (string * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> string
val instructionToString: instruction -> string
val form1:
  (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * BitsN.nbit)))) ->
  BitsN.nbit
val form2: (BitsN.nbit * (BitsN.nbit * BitsN.nbit)) -> BitsN.nbit
val form3:
  (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> BitsN.nbit
val form4:
  (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> BitsN.nbit
val form5:
  (BitsN.nbit * (BitsN.nbit * (BitsN.nbit * BitsN.nbit))) -> BitsN.nbit
val Encode: instruction -> BitsN.nbit

end