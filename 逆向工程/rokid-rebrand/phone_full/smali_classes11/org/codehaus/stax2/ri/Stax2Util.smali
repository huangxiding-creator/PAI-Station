.class public final Lorg/codehaus/stax2/ri/Stax2Util;
.super Ljava/lang/Object;
.source "Stax2Util.java"

# interfaces
.implements Ljavax/xml/stream/XMLStreamConstants;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;,
        Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final _isSpace(C)Z
    .locals 1
    .param p0, "c"    # C

    .line 101
    const/16 v0, 0x20

    if-gt p0, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static eventTypeDesc(I)Ljava/lang/String;
    .locals 2
    .param p0, "type"    # I

    .line 31
    packed-switch p0, :pswitch_data_0

    .line 57
    :pswitch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 44
    :pswitch_1
    const-string v0, "CDATA"

    return-object v0

    .line 53
    :pswitch_2
    const-string v0, "DTD"

    return-object v0

    .line 55
    :pswitch_3
    const-string v0, "ENTITY_REFERENCE"

    return-object v0

    .line 39
    :pswitch_4
    const-string v0, "END_DOCUMENT"

    return-object v0

    .line 37
    :pswitch_5
    const-string v0, "START_DOCUMENT"

    return-object v0

    .line 46
    :pswitch_6
    const-string v0, "SPACE"

    return-object v0

    .line 49
    :pswitch_7
    const-string v0, "COMMENT"

    return-object v0

    .line 42
    :pswitch_8
    const-string v0, "CHARACTERS"

    return-object v0

    .line 51
    :pswitch_9
    const-string v0, "PROCESSING_INSTRUCTION"

    return-object v0

    .line 35
    :pswitch_a
    const-string v0, "END_ELEMENT"

    return-object v0

    .line 33
    :pswitch_b
    const-string v0, "START_ELEMENT"

    return-object v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public static trimSpaces(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "lexical"    # Ljava/lang/String;

    .line 68
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 69
    .local v0, "end":I
    const/4 v1, 0x0

    .line 72
    .local v1, "start":I
    :goto_0
    if-lt v1, v0, :cond_0

    .line 73
    const/4 v2, 0x0

    return-object v2

    .line 75
    :cond_0
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lorg/codehaus/stax2/ri/Stax2Util;->_isSpace(C)Z

    move-result v2

    if-nez v2, :cond_4

    .line 76
    nop

    .line 81
    add-int/lit8 v0, v0, -0x1

    .line 82
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lorg/codehaus/stax2/ri/Stax2Util;->_isSpace(C)Z

    move-result v2

    if-nez v2, :cond_2

    .line 83
    if-nez v1, :cond_1

    move-object v2, p0

    goto :goto_1

    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    :goto_1
    return-object v2

    .line 87
    :cond_2
    :goto_2
    add-int/lit8 v0, v0, -0x1

    if-le v0, v1, :cond_3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lorg/codehaus/stax2/ri/Stax2Util;->_isSpace(C)Z

    move-result v2

    if-eqz v2, :cond_3

    goto :goto_2

    .line 89
    :cond_3
    add-int/lit8 v2, v0, 0x1

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 78
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method
