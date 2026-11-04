.class public final Lcom/fasterxml/aalto/out/OutputCharTypes;
.super Lcom/fasterxml/aalto/util/XmlCharTypes;
.source "OutputCharTypes.java"


# static fields
.field public static final CT_OUTPUT_MUST_QUOTE:I = 0x4

.field public static final CT_OUTPUT_NAME_ANY_MB2:I = 0x6

.field public static final CT_OUTPUT_NAME_NONFIRST_MB2:I = 0x5

.field public static final CT_OUTPUT_NAME_UNENCODABLE:I = 0x4

.field static final MAIN_TABLE_SIZE:I = 0x800

.field private static sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field private static sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field private static final sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 53
    const/4 v0, 0x0

    sput-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 55
    sput-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 60
    new-instance v0, Lcom/fasterxml/aalto/util/XmlCharTypes;

    const/16 v1, 0x800

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>(I)V

    sput-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 66
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    sget-object v1, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    sget-object v2, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    sget-object v3, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    sget-object v4, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v4, v4, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0, v1, v2, v3, v4}, Lcom/fasterxml/aalto/out/OutputCharTypes;->fillInLatin1Chars([I[I[I[I[I)V

    .line 75
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForUtf8([I)V

    .line 76
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForUtf8([I)V

    .line 77
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForUtf8([I)V

    .line 78
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForUtf8([I)V

    .line 83
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyUtf8Names([I)V

    .line 88
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAttrWrite([I)V

    .line 89
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>()V

    return-void
.end method

.method public static final getAsciiCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 5

    .line 119
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    if-nez v0, :cond_0

    .line 120
    new-instance v0, Lcom/fasterxml/aalto/util/XmlCharTypes;

    const/16 v1, 0x800

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>(I)V

    sput-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 122
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    sget-object v1, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    sget-object v2, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    sget-object v3, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    sget-object v4, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v4, v4, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0, v1, v2, v3, v4}, Lcom/fasterxml/aalto/out/OutputCharTypes;->fillInLatin1Chars([I[I[I[I[I)V

    .line 128
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAscii([I)V

    .line 129
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAscii([I)V

    .line 130
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAscii([I)V

    .line 131
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAscii([I)V

    .line 132
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyAsciiNames([I)V

    .line 135
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAttrWrite([I)V

    .line 137
    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sAsciiCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    return-object v0
.end method

.method public static final getLatin1CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 5

    .line 98
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    if-nez v0, :cond_0

    .line 99
    new-instance v0, Lcom/fasterxml/aalto/util/XmlCharTypes;

    const/16 v1, 0x800

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/util/XmlCharTypes;-><init>(I)V

    sput-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 100
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    sget-object v1, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    sget-object v2, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    sget-object v3, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    sget-object v4, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v4, v4, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0, v1, v2, v3, v4}, Lcom/fasterxml/aalto/out/OutputCharTypes;->fillInLatin1Chars([I[I[I[I[I)V

    .line 105
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForLatin1([I)V

    .line 106
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForLatin1([I)V

    .line 107
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForLatin1([I)V

    .line 108
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForLatin1([I)V

    .line 112
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    invoke-static {v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyForAttrWrite([I)V

    .line 114
    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sLatin1CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    return-object v0
.end method

.method public static final getUtf8CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 1

    .line 93
    sget-object v0, Lcom/fasterxml/aalto/out/OutputCharTypes;->sUtf8CharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    return-object v0
.end method

.method private static modifyAsciiNames([I)V
    .locals 4
    .param p0, "charTable"    # [I

    .line 195
    invoke-static {p0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->modifyLatin1Names([I)V

    .line 196
    const/16 v0, 0x80

    .local v0, "i":I
    array-length v1, p0

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 198
    aget v2, p0, v0

    .line 199
    .local v2, "val":I
    const/4 v3, 0x2

    if-eq v2, v3, :cond_0

    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    .line 200
    :cond_0
    const/4 v3, 0x4

    aput v3, p0, v0

    .line 196
    .end local v2    # "val":I
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 203
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    return-void
.end method

.method private static modifyForAscii([I)V
    .locals 1
    .param p0, "charTable"    # [I

    .line 190
    const/16 v0, 0x7f

    invoke-static {p0, v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->requireQuotingAfter([II)V

    .line 191
    return-void
.end method

.method private static modifyForAttrWrite([I)V
    .locals 2
    .param p0, "charTable"    # [I

    .line 207
    const/16 v0, 0x9

    const/4 v1, 0x4

    aput v1, p0, v0

    .line 208
    return-void
.end method

.method private static modifyForLatin1([I)V
    .locals 2
    .param p0, "charTable"    # [I

    .line 145
    const/16 v0, 0x7f

    .local v0, "i":I
    :goto_0
    const/16 v1, 0x9f

    if-gt v0, v1, :cond_0

    .line 146
    const/4 v1, 0x4

    aput v1, p0, v0

    .line 145
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 148
    .end local v0    # "i":I
    :cond_0
    const/16 v0, 0xff

    invoke-static {p0, v0}, Lcom/fasterxml/aalto/out/OutputCharTypes;->requireQuotingAfter([II)V

    .line 149
    return-void
.end method

.method private static modifyForUtf8([I)V
    .locals 3
    .param p0, "charTable"    # [I

    .line 164
    const/16 v0, 0x80

    .local v0, "i":I
    array-length v1, p0

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 166
    aget v2, p0, v0

    if-nez v2, :cond_0

    .line 167
    const/4 v2, 0x5

    aput v2, p0, v0

    .line 164
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 170
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_1
    return-void
.end method

.method private static modifyLatin1Names([I)V
    .locals 4
    .param p0, "charTable"    # [I

    .line 153
    const/16 v0, 0x100

    .local v0, "i":I
    array-length v1, p0

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 155
    aget v2, p0, v0

    .line 156
    .local v2, "val":I
    const/4 v3, 0x2

    if-eq v2, v3, :cond_0

    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    .line 157
    :cond_0
    const/4 v3, 0x4

    aput v3, p0, v0

    .line 153
    .end local v2    # "val":I
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 160
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    return-void
.end method

.method private static modifyUtf8Names([I)V
    .locals 3
    .param p0, "charTable"    # [I

    .line 177
    const/16 v0, 0x80

    .local v0, "i":I
    array-length v1, p0

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 178
    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 179
    const/4 v2, 0x6

    aput v2, p0, v0

    goto :goto_1

    .line 180
    :cond_0
    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 181
    const/4 v2, 0x5

    aput v2, p0, v0

    goto :goto_1

    .line 183
    :cond_1
    const/4 v2, 0x0

    aput v2, p0, v0

    .line 177
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 186
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    return-void
.end method

.method private static requireQuotingAfter([II)V
    .locals 3
    .param p0, "charTable"    # [I
    .param p1, "lastValid"    # I

    .line 213
    add-int/lit8 v0, p1, 0x1

    .local v0, "i":I
    array-length v1, p0

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 215
    aget v2, p0, v0

    if-nez v2, :cond_0

    .line 216
    const/4 v2, 0x4

    aput v2, p0, v0

    .line 213
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 219
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_1
    return-void
.end method
