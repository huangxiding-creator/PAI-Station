.class public Lcom/fasterxml/aalto/util/XmlCharTypes;
.super Ljava/lang/Object;
.source "XmlCharTypes.java"


# static fields
.field public static final CT_AMP:I = 0xa

.field public static final CT_ATTR_QUOTE:I = 0xe

.field public static final CT_DTD_GT:I = 0xa

.field public static final CT_DTD_LT:I = 0x9

.field public static final CT_DTD_PERCENT:I = 0xc

.field public static final CT_DTD_QUOTE:I = 0x8

.field public static final CT_DTD_RBRACKET:I = 0xb

.field public static final CT_GT:I = 0x11

.field public static final CT_HYPHEN:I = 0xd

.field public static final CT_INVALID:I = 0x1

.field public static final CT_LBRACKET:I = 0x10

.field public static final CT_LT:I = 0x9

.field public static final CT_MULTIBYTE_2:I = 0x5

.field public static final CT_MULTIBYTE_3:I = 0x6

.field public static final CT_MULTIBYTE_4:I = 0x7

.field public static final CT_MULTIBYTE_N:I = 0x4

.field public static final CT_NAME_ANY:I = 0x3

.field public static final CT_NAME_COLON:I = 0x1

.field public static final CT_NAME_NONE:I = 0x0

.field public static final CT_NAME_NONFIRST:I = 0x2

.field public static final CT_OK:I = 0x0

.field public static final CT_QMARK:I = 0xc

.field public static final CT_RBRACKET:I = 0xb

.field public static final CT_WS_CR:I = 0x2

.field public static final CT_WS_LF:I = 0x3

.field public static final CT_WS_TAB:I = 0x8

.field public static final PUBID_CHARS:[I

.field public static final PUBID_INVALID:I = 0x0

.field public static final PUBID_OK:I = 0x1


# instance fields
.field public final ATTR_CHARS:[I

.field public final DTD_CHARS:[I

.field public final NAME_CHARS:[I

.field public final OTHER_CHARS:[I

.field public final TEXT_CHARS:[I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 110
    const/16 v0, 0x100

    new-array v0, v0, [I

    sput-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    .line 112
    const/4 v0, 0x0

    .local v0, "i":I
    const/16 v1, 0x19

    .local v1, "last":I
    :goto_0
    const/4 v2, 0x1

    if-gt v0, v1, :cond_0

    .line 113
    sget-object v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    add-int/lit8 v4, v0, 0x41

    aput v2, v3, v4

    .line 114
    sget-object v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    add-int/lit8 v4, v0, 0x61

    aput v2, v3, v4

    .line 112
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 116
    .end local v0    # "i":I
    .end local v1    # "last":I
    :cond_0
    const/16 v0, 0x30

    .restart local v0    # "i":I
    :goto_1
    const/16 v1, 0x39

    if-gt v0, v1, :cond_1

    .line 117
    sget-object v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    aput v2, v1, v0

    .line 116
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 121
    .end local v0    # "i":I
    :cond_1
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0xa

    aput v2, v0, v1

    .line 122
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0xd

    aput v2, v0, v1

    .line 123
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x20

    aput v2, v0, v1

    .line 126
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x2d

    aput v2, v0, v1

    .line 127
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x27

    aput v2, v0, v1

    .line 128
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x28

    aput v2, v0, v1

    .line 129
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x29

    aput v2, v0, v1

    .line 130
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x2b

    aput v2, v0, v1

    .line 131
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x2c

    aput v2, v0, v1

    .line 132
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x2e

    aput v2, v0, v1

    .line 133
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x2f

    aput v2, v0, v1

    .line 134
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x3a

    aput v2, v0, v1

    .line 135
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x3d

    aput v2, v0, v1

    .line 136
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x3f

    aput v2, v0, v1

    .line 137
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x3b

    aput v2, v0, v1

    .line 138
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x21

    aput v2, v0, v1

    .line 139
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x2a

    aput v2, v0, v1

    .line 140
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x23

    aput v2, v0, v1

    .line 141
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x40

    aput v2, v0, v1

    .line 142
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x24

    aput v2, v0, v1

    .line 143
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x5f

    aput v2, v0, v1

    .line 144
    sget-object v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    const/16 v1, 0x25

    aput v2, v0, v1

    .line 145
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 147
    const/16 v0, 0x100

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>(I)V

    return-void
.end method

.method public constructor <init>(I)V
    .locals 1
    .param p1, "size"    # I

    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 150
    new-array v0, p1, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 151
    new-array v0, p1, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 152
    new-array v0, p1, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    .line 153
    new-array v0, p1, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    .line 154
    new-array v0, p1, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 155
    return-void
.end method

.method protected static fillIn8BitAttrRange([I)V
    .locals 2
    .param p0, "arr"    # [I

    .line 255
    invoke-static {p0}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillInCommonTextRange([I)V

    .line 256
    const/16 v0, 0x8

    const/16 v1, 0x9

    aput v0, p0, v1

    .line 257
    const/16 v0, 0x3c

    aput v1, p0, v0

    .line 258
    const/16 v0, 0x26

    const/16 v1, 0xa

    aput v1, p0, v0

    .line 259
    const/16 v0, 0x27

    const/16 v1, 0xe

    aput v1, p0, v0

    .line 260
    const/16 v0, 0x22

    aput v1, p0, v0

    .line 261
    return-void
.end method

.method protected static fillIn8BitDtdRange([I)V
    .locals 2
    .param p0, "arr"    # [I

    .line 265
    invoke-static {p0}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillInCommonTextRange([I)V

    .line 266
    const/16 v0, 0x27

    const/16 v1, 0x8

    aput v1, p0, v0

    .line 267
    const/16 v0, 0x22

    aput v1, p0, v0

    .line 268
    const/16 v0, 0x3c

    const/16 v1, 0x9

    aput v1, p0, v0

    .line 269
    const/16 v0, 0x3e

    const/16 v1, 0xa

    aput v1, p0, v0

    .line 271
    const/16 v0, 0x5d

    const/16 v1, 0xb

    aput v1, p0, v0

    .line 272
    const/16 v0, 0x25

    const/16 v1, 0xc

    aput v1, p0, v0

    .line 273
    return-void
.end method

.method public static fillIn8BitNameRange([I)V
    .locals 3
    .param p0, "arr"    # [I

    .line 221
    const/16 v0, 0x61

    .local v0, "i":I
    :goto_0
    const/16 v1, 0x7a

    const/4 v2, 0x3

    if-gt v0, v1, :cond_0

    .line 222
    aput v2, p0, v0

    .line 221
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 224
    .end local v0    # "i":I
    :cond_0
    const/16 v0, 0x41

    .restart local v0    # "i":I
    :goto_1
    const/16 v1, 0x5a

    if-gt v0, v1, :cond_1

    .line 225
    aput v2, p0, v0

    .line 224
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 228
    .end local v0    # "i":I
    :cond_1
    const/16 v0, 0x5f

    aput v2, p0, v0

    .line 231
    const/16 v0, 0x3a

    const/4 v1, 0x1

    aput v1, p0, v0

    .line 232
    const/16 v0, 0x2d

    const/4 v1, 0x2

    aput v1, p0, v0

    .line 233
    const/16 v0, 0x2e

    aput v1, p0, v0

    .line 234
    const/16 v0, 0x30

    .restart local v0    # "i":I
    :goto_2
    const/16 v2, 0x39

    if-gt v0, v2, :cond_2

    .line 235
    aput v1, p0, v0

    .line 234
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 237
    .end local v0    # "i":I
    :cond_2
    return-void
.end method

.method protected static fillIn8BitTextRange([I)V
    .locals 2
    .param p0, "arr"    # [I

    .line 244
    invoke-static {p0}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillInCommonTextRange([I)V

    .line 245
    const/16 v0, 0x3c

    const/16 v1, 0x9

    aput v1, p0, v0

    .line 246
    const/16 v0, 0x26

    const/16 v1, 0xa

    aput v1, p0, v0

    .line 247
    const/16 v0, 0x5d

    const/16 v1, 0xb

    aput v1, p0, v0

    .line 248
    return-void
.end method

.method private static fillInCommonTextRange([I)V
    .locals 2
    .param p0, "arr"    # [I

    .line 210
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0x20

    if-ge v0, v1, :cond_0

    .line 211
    const/4 v1, 0x1

    aput v1, p0, v0

    .line 210
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 214
    .end local v0    # "i":I
    :cond_0
    const/16 v0, 0xd

    const/4 v1, 0x2

    aput v1, p0, v0

    .line 215
    const/16 v0, 0xa

    const/4 v1, 0x3

    aput v1, p0, v0

    .line 216
    const/16 v0, 0x9

    const/4 v1, 0x0

    aput v1, p0, v0

    .line 217
    return-void
.end method

.method public static fillInLatin1Chars([I[I[I[I[I)V
    .locals 2
    .param p0, "textChars"    # [I
    .param p1, "attrChars"    # [I
    .param p2, "nameChars"    # [I
    .param p3, "dtdChars"    # [I
    .param p4, "otherChars"    # [I

    .line 164
    invoke-static {p0}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillIn8BitTextRange([I)V

    .line 168
    invoke-static {p1}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillIn8BitAttrRange([I)V

    .line 172
    invoke-static {p2}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillIn8BitNameRange([I)V

    .line 174
    const/16 v0, 0xc0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xff

    if-gt v0, v1, :cond_1

    .line 175
    const/16 v1, 0xd7

    if-eq v0, v1, :cond_0

    const/16 v1, 0xf7

    if-eq v0, v1, :cond_0

    .line 176
    const/4 v1, 0x3

    aput v1, p2, v0

    .line 174
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 179
    .end local v0    # "i":I
    :cond_1
    const/16 v0, 0xb7

    const/4 v1, 0x2

    aput v1, p2, v0

    .line 182
    invoke-static {p3}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillIn8BitDtdRange([I)V

    .line 188
    invoke-static {p4}, Lcom/fasterxml/aalto/util/XmlCharTypes;->fillIn8BitTextRange([I)V

    .line 194
    const/16 v0, 0x26

    const/4 v1, 0x0

    aput v1, p4, v0

    .line 195
    const/16 v0, 0x3c

    aput v1, p4, v0

    .line 197
    const/16 v0, 0x5d

    const/16 v1, 0xb

    aput v1, p4, v0

    .line 198
    const/16 v0, 0x3f

    const/16 v1, 0xc

    aput v1, p4, v0

    .line 199
    const/16 v0, 0x2d

    const/16 v1, 0xd

    aput v1, p4, v0

    .line 200
    return-void
.end method
