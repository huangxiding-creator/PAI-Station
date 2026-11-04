.class public final Lcom/fasterxml/aalto/in/InputCharTypes;
.super Lcom/fasterxml/aalto/util/XmlCharTypes;
.source "InputCharTypes.java"


# static fields
.field public static final CT_INPUT_NAME_MB_2:I = 0x5

.field public static final CT_INPUT_NAME_MB_3:I = 0x6

.field public static final CT_INPUT_NAME_MB_4:I = 0x7

.field public static final CT_INPUT_NAME_MB_N:I = 0x4

.field private static sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field private static sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field private static final sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 43
    const/4 v0, 0x0

    sput-object v0, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 45
    sput-object v0, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 50
    new-instance v0, Lcom/fasterxml/aalto/util/XmlCharTypes;

    invoke-direct {v0}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 52
    sget-object v0, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    sget-object v2, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    sget-object v3, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    sget-object v4, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v4, v4, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0, v1, v2, v3, v4}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInUtf8Chars([I[I[I[I[I)V

    .line 57
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>()V

    return-void
.end method

.method protected static fillInIllegalAsciiRange([I)V
    .locals 2
    .param p0, "arr"    # [I

    .line 183
    const/16 v0, 0x80

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xff

    if-gt v0, v1, :cond_0

    .line 184
    const/4 v1, 0x1

    aput v1, p0, v0

    .line 183
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 186
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method private static fillInMultiByteNameRange([I)V
    .locals 3
    .param p0, "arr"    # [I

    .line 163
    const/16 v0, 0x80

    .local v0, "c":I
    :goto_0
    const/16 v1, 0x100

    if-ge v0, v1, :cond_3

    .line 167
    and-int/lit16 v1, v0, 0xe0

    const/16 v2, 0xc0

    if-ne v1, v2, :cond_0

    .line 168
    const/4 v1, 0x5

    .local v1, "code":I
    goto :goto_1

    .line 169
    .end local v1    # "code":I
    :cond_0
    and-int/lit16 v1, v0, 0xf0

    const/16 v2, 0xe0

    if-ne v1, v2, :cond_1

    .line 170
    const/4 v1, 0x6

    .restart local v1    # "code":I
    goto :goto_1

    .line 171
    .end local v1    # "code":I
    :cond_1
    and-int/lit16 v1, v0, 0xf8

    const/16 v2, 0xf0

    if-ne v1, v2, :cond_2

    .line 173
    const/4 v1, 0x7

    .restart local v1    # "code":I
    goto :goto_1

    .line 175
    .end local v1    # "code":I
    :cond_2
    const/4 v1, 0x1

    .line 177
    .restart local v1    # "code":I
    :goto_1
    aput v1, p0, v0

    .line 163
    .end local v1    # "code":I
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 179
    .end local v0    # "c":I
    :cond_3
    return-void
.end method

.method private static fillInMultiByteTextRange([I)V
    .locals 3
    .param p0, "arr"    # [I

    .line 143
    const/16 v0, 0x80

    .local v0, "c":I
    :goto_0
    const/16 v1, 0x100

    if-ge v0, v1, :cond_3

    .line 147
    and-int/lit16 v1, v0, 0xe0

    const/16 v2, 0xc0

    if-ne v1, v2, :cond_0

    .line 148
    const/4 v1, 0x5

    .local v1, "code":I
    goto :goto_1

    .line 149
    .end local v1    # "code":I
    :cond_0
    and-int/lit16 v1, v0, 0xf0

    const/16 v2, 0xe0

    if-ne v1, v2, :cond_1

    .line 150
    const/4 v1, 0x6

    .restart local v1    # "code":I
    goto :goto_1

    .line 151
    .end local v1    # "code":I
    :cond_1
    and-int/lit16 v1, v0, 0xf8

    const/16 v2, 0xf0

    if-ne v1, v2, :cond_2

    .line 153
    const/4 v1, 0x7

    .restart local v1    # "code":I
    goto :goto_1

    .line 155
    .end local v1    # "code":I
    :cond_2
    const/4 v1, 0x1

    .line 157
    .restart local v1    # "code":I
    :goto_1
    aput v1, p0, v0

    .line 143
    .end local v1    # "code":I
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 159
    .end local v0    # "c":I
    :cond_3
    return-void
.end method

.method public static fillInUtf8Chars([I[I[I[I[I)V
    .locals 4
    .param p0, "textChars"    # [I
    .param p1, "attrChars"    # [I
    .param p2, "nameChars"    # [I
    .param p3, "dtdChars"    # [I
    .param p4, "otherChars"    # [I

    .line 100
    invoke-static {p0}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillIn8BitTextRange([I)V

    .line 101
    invoke-static {p0}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInMultiByteTextRange([I)V

    .line 104
    invoke-static {p1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillIn8BitAttrRange([I)V

    .line 105
    invoke-static {p1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInMultiByteTextRange([I)V

    .line 108
    invoke-static {p2}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillIn8BitNameRange([I)V

    .line 112
    invoke-static {p2}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInMultiByteNameRange([I)V

    .line 115
    invoke-static {p3}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillIn8BitDtdRange([I)V

    .line 116
    invoke-static {p3}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInMultiByteTextRange([I)V

    .line 121
    const/16 v0, 0x5d

    const/16 v1, 0xb

    aput v1, p4, v0

    .line 122
    const/16 v2, 0x3e

    const/16 v3, 0x11

    aput v3, p4, v2

    .line 126
    invoke-static {p4}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillIn8BitTextRange([I)V

    .line 127
    invoke-static {p4}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInMultiByteTextRange([I)V

    .line 133
    const/16 v2, 0x26

    const/4 v3, 0x0

    aput v3, p4, v2

    .line 134
    const/16 v2, 0x3c

    aput v3, p4, v2

    .line 136
    aput v1, p4, v0

    .line 137
    const/16 v0, 0x3f

    const/16 v1, 0xc

    aput v1, p4, v0

    .line 138
    const/16 v0, 0x2d

    const/16 v1, 0xd

    aput v1, p4, v0

    .line 139
    return-void
.end method

.method public static final declared-synchronized getAsciiCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 6

    const-class v0, Lcom/fasterxml/aalto/in/InputCharTypes;

    monitor-enter v0

    .line 66
    :try_start_0
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    if-nez v1, :cond_0

    .line 67
    new-instance v1, Lcom/fasterxml/aalto/util/XmlCharTypes;

    invoke-direct {v1}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>()V

    sput-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 68
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    sget-object v2, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    sget-object v3, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    sget-object v4, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v4, v4, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    sget-object v5, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v5, v5, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v1, v2, v3, v4, v5}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInLatin1Chars([I[I[I[I[I)V

    .line 74
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    invoke-static {v1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInIllegalAsciiRange([I)V

    .line 75
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInIllegalAsciiRange([I)V

    .line 76
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    invoke-static {v1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInIllegalAsciiRange([I)V

    .line 77
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    invoke-static {v1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInIllegalAsciiRange([I)V

    .line 78
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v1}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInIllegalAsciiRange([I)V

    .line 80
    :cond_0
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 65
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static final declared-synchronized getLatin1CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 6

    const-class v0, Lcom/fasterxml/aalto/in/InputCharTypes;

    monitor-enter v0

    .line 85
    :try_start_0
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    if-nez v1, :cond_0

    .line 86
    new-instance v1, Lcom/fasterxml/aalto/util/XmlCharTypes;

    invoke-direct {v1}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>()V

    sput-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 87
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    sget-object v2, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    sget-object v3, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    sget-object v4, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v4, v4, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    sget-object v5, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v5, v5, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v1, v2, v3, v4, v5}, Lcom/fasterxml/aalto/in/InputCharTypes;->fillInLatin1Chars([I[I[I[I[I)V

    .line 93
    :cond_0
    sget-object v1, Lcom/fasterxml/aalto/in/InputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 84
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static final getUtf8CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 1

    .line 61
    sget-object v0, Lcom/fasterxml/aalto/in/InputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    return-object v0
.end method
