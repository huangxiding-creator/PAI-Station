.class Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;
.super Lorg/apache/log4j/pattern/NameAbbreviator;
.source "NameAbbreviator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/log4j/pattern/NameAbbreviator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "PatternAbbreviator"
.end annotation


# instance fields
.field private final fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;


# direct methods
.method public constructor <init>(Ljava/util/List;)V
    .locals 2
    .param p1, "fragments"    # Ljava/util/List;

    .line 313
    invoke-direct {p0}, Lorg/apache/log4j/pattern/NameAbbreviator;-><init>()V

    .line 314
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-eqz v0, :cond_0

    .line 319
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    iput-object v0, p0, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;->fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    .line 320
    iget-object v0, p0, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;->fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    invoke-interface {p1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 321
    return-void

    .line 315
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "fragments must have at least one element"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public abbreviate(ILjava/lang/StringBuffer;)V
    .locals 3
    .param p1, "nameStart"    # I
    .param p2, "buf"    # Ljava/lang/StringBuffer;

    .line 332
    move v0, p1

    .line 334
    .local v0, "pos":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;->fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_0

    invoke-virtual {p2}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    if-ge v0, v2, :cond_0

    .line 336
    iget-object v2, p0, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;->fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    aget-object v2, v2, v1

    invoke-virtual {v2, p2, v0}, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;->abbreviate(Ljava/lang/StringBuffer;I)I

    move-result v0

    .line 335
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 342
    .end local v1    # "i":I
    :cond_0
    iget-object v1, p0, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;->fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    iget-object v2, p0, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviator;->fragments:[Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    aget-object v1, v1, v2

    .line 345
    .local v1, "terminalFragment":Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;
    :goto_1
    invoke-virtual {p2}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    if-ge v0, v2, :cond_1

    if-ltz v0, :cond_1

    .line 346
    invoke-virtual {v1, p2, v0}, Lorg/apache/log4j/pattern/NameAbbreviator$PatternAbbreviatorFragment;->abbreviate(Ljava/lang/StringBuffer;I)I

    move-result v0

    goto :goto_1

    .line 348
    :cond_1
    return-void
.end method
