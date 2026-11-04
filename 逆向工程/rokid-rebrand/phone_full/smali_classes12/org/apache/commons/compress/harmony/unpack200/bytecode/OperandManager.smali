.class public Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;
.super Ljava/lang/Object;
.source "OperandManager.java"


# instance fields
.field bcByte:[I

.field bcByteIndex:I

.field bcCaseCount:[I

.field bcCaseCountIndex:I

.field bcCaseValue:[I

.field bcCaseValueIndex:I

.field bcClassRef:[I

.field bcClassRefIndex:I

.field bcDoubleRef:[I

.field bcDoubleRefIndex:I

.field bcFieldRef:[I

.field bcFieldRefIndex:I

.field bcFloatRef:[I

.field bcFloatRefIndex:I

.field bcIMethodRef:[I

.field bcIMethodRefIndex:I

.field bcInitRef:[I

.field bcInitRefIndex:I

.field bcIntRef:[I

.field bcIntRefIndex:I

.field bcLabel:[I

.field bcLabelIndex:I

.field bcLocal:[I

.field bcLocalIndex:I

.field bcLongRef:[I

.field bcLongRefIndex:I

.field bcMethodRef:[I

.field bcMethodRefIndex:I

.field bcShort:[I

.field bcShortIndex:I

.field bcStringRef:[I

.field bcStringRefIndex:I

.field bcSuperField:[I

.field bcSuperFieldIndex:I

.field bcSuperMethod:[I

.field bcSuperMethodIndex:I

.field bcThisField:[I

.field bcThisFieldIndex:I

.field bcThisMethod:[I

.field bcThisMethodIndex:I

.field currentClass:Ljava/lang/String;

.field newClass:Ljava/lang/String;

.field segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

.field superClass:Ljava/lang/String;

.field wideByteCodeIndex:I

.field wideByteCodes:[I


# direct methods
.method public constructor <init>([I[I[I[I[I[I[I[I[I[I[I[I[I[I[I[I[I[I[I[I[I)V
    .locals 16
    .param p1, "bcCaseCount"    # [I
    .param p2, "bcCaseValue"    # [I
    .param p3, "bcByte"    # [I
    .param p4, "bcShort"    # [I
    .param p5, "bcLocal"    # [I
    .param p6, "bcLabel"    # [I
    .param p7, "bcIntRef"    # [I
    .param p8, "bcFloatRef"    # [I
    .param p9, "bcLongRef"    # [I
    .param p10, "bcDoubleRef"    # [I
    .param p11, "bcStringRef"    # [I
    .param p12, "bcClassRef"    # [I
    .param p13, "bcFieldRef"    # [I
    .param p14, "bcMethodRef"    # [I
    .param p15, "bcIMethodRef"    # [I
    .param p16, "bcThisField"    # [I
    .param p17, "bcSuperField"    # [I
    .param p18, "bcThisMethod"    # [I
    .param p19, "bcSuperMethod"    # [I
    .param p20, "bcInitRef"    # [I
    .param p21, "wideByteCodes"    # [I

    .line 83
    move-object/from16 v0, p0

    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 84
    move-object/from16 v1, p1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseCount:[I

    .line 85
    move-object/from16 v2, p2

    iput-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseValue:[I

    .line 86
    move-object/from16 v3, p3

    iput-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcByte:[I

    .line 87
    move-object/from16 v4, p4

    iput-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcShort:[I

    .line 88
    move-object/from16 v5, p5

    iput-object v5, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLocal:[I

    .line 89
    move-object/from16 v6, p6

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLabel:[I

    .line 90
    move-object/from16 v7, p7

    iput-object v7, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIntRef:[I

    .line 91
    move-object/from16 v8, p8

    iput-object v8, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFloatRef:[I

    .line 92
    move-object/from16 v9, p9

    iput-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLongRef:[I

    .line 93
    move-object/from16 v10, p10

    iput-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcDoubleRef:[I

    .line 94
    move-object/from16 v11, p11

    iput-object v11, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcStringRef:[I

    .line 95
    move-object/from16 v12, p12

    iput-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcClassRef:[I

    .line 96
    move-object/from16 v13, p13

    iput-object v13, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFieldRef:[I

    .line 97
    move-object/from16 v14, p14

    iput-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcMethodRef:[I

    .line 98
    move-object/from16 v15, p15

    iput-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIMethodRef:[I

    .line 100
    move-object/from16 v1, p16

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisField:[I

    .line 101
    move-object/from16 v1, p17

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperField:[I

    .line 102
    move-object/from16 v1, p18

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisMethod:[I

    .line 103
    move-object/from16 v1, p19

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperMethod:[I

    .line 104
    move-object/from16 v1, p20

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcInitRef:[I

    .line 105
    move-object/from16 v1, p21

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->wideByteCodes:[I

    .line 106
    return-void
.end method


# virtual methods
.method public getCurrentClass()Ljava/lang/String;
    .locals 2

    .line 213
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->currentClass:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 216
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->currentClass:Ljava/lang/String;

    return-object v0

    .line 214
    :cond_0
    new-instance v0, Ljava/lang/Error;

    const-string v1, "Current class not set yet"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getNewClass()Ljava/lang/String;
    .locals 2

    .line 227
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->newClass:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 230
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->newClass:Ljava/lang/String;

    return-object v0

    .line 228
    :cond_0
    new-instance v0, Ljava/lang/Error;

    const-string v1, "New class not set yet"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getSuperClass()Ljava/lang/String;
    .locals 2

    .line 220
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->superClass:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 223
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->superClass:Ljava/lang/String;

    return-object v0

    .line 221
    :cond_0
    new-instance v0, Ljava/lang/Error;

    const-string v1, "SuperClass not set yet"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public globalConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;
    .locals 1

    .line 197
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v0

    return-object v0
.end method

.method public nextByte()I
    .locals 3

    .line 117
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcByte:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcByteIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcByteIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextCaseCount()I
    .locals 3

    .line 109
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseCount:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseCountIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseCountIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextCaseValues()I
    .locals 3

    .line 113
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseValue:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseValueIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcCaseValueIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextClassRef()I
    .locals 3

    .line 153
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcClassRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcClassRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcClassRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextDoubleRef()I
    .locals 3

    .line 145
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcDoubleRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcDoubleRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcDoubleRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextFieldRef()I
    .locals 3

    .line 157
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFieldRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFieldRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFieldRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextFloatRef()I
    .locals 3

    .line 137
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFloatRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFloatRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcFloatRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextIMethodRef()I
    .locals 3

    .line 165
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIMethodRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIMethodRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIMethodRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextInitRef()I
    .locals 3

    .line 185
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcInitRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcInitRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcInitRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextIntRef()I
    .locals 3

    .line 133
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIntRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIntRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcIntRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextLabel()I
    .locals 3

    .line 129
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLabel:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLabelIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLabelIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextLocal()I
    .locals 3

    .line 125
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLocal:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLocalIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLocalIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextLongRef()I
    .locals 3

    .line 141
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLongRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLongRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcLongRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextMethodRef()I
    .locals 3

    .line 161
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcMethodRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcMethodRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcMethodRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextShort()I
    .locals 3

    .line 121
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcShort:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcShortIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcShortIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextStringRef()I
    .locals 3

    .line 149
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcStringRef:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcStringRefIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcStringRefIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextSuperFieldRef()I
    .locals 3

    .line 173
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperField:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperFieldIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperFieldIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextSuperMethodRef()I
    .locals 3

    .line 181
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperMethod:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperMethodIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcSuperMethodIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextThisFieldRef()I
    .locals 3

    .line 169
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisField:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisFieldIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisFieldIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextThisMethodRef()I
    .locals 3

    .line 177
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisMethod:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisMethodIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->bcThisMethodIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public nextWideByteCode()I
    .locals 3

    .line 189
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->wideByteCodes:[I

    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->wideByteCodeIndex:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->wideByteCodeIndex:I

    aget v0, v0, v1

    return v0
.end method

.method public setCurrentClass(Ljava/lang/String;)V
    .locals 0
    .param p1, "string"    # Ljava/lang/String;

    .line 201
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->currentClass:Ljava/lang/String;

    .line 202
    return-void
.end method

.method public setNewClass(Ljava/lang/String;)V
    .locals 0
    .param p1, "string"    # Ljava/lang/String;

    .line 209
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->newClass:Ljava/lang/String;

    .line 210
    return-void
.end method

.method public setSegment(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V
    .locals 0
    .param p1, "segment"    # Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 193
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 194
    return-void
.end method

.method public setSuperClass(Ljava/lang/String;)V
    .locals 0
    .param p1, "string"    # Ljava/lang/String;

    .line 205
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->superClass:Ljava/lang/String;

    .line 206
    return-void
.end method
