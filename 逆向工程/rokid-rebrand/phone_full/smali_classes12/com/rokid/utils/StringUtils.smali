.class public Lcom/rokid/utils/StringUtils;
.super Ljava/lang/Object;
.source "StringUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isNotNullAndNotEmpty(Ljava/lang/CharSequence;)Z
    .locals 1
    .param p0, "sequence"    # Ljava/lang/CharSequence;

    .line 18
    invoke-static {p0}, Lcom/rokid/utils/StringUtils;->isNullOrEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static isNullOrEmpty(Ljava/lang/CharSequence;)Z
    .locals 2
    .param p0, "sequence"    # Ljava/lang/CharSequence;

    .line 14
    const/4 v0, 0x1

    if-eqz p0, :cond_1

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-ge v1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    :goto_0
    return v0
.end method
