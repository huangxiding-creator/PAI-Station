.class public Lorg/apache/commons/compress/harmony/pack200/CPClass;
.super Lorg/apache/commons/compress/harmony/pack200/CPConstant;
.source "CPClass.java"

# interfaces
.implements Ljava/lang/Comparable;


# instance fields
.field private final className:Ljava/lang/String;

.field private final isInnerClass:Z

.field private final utf8:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/pack200/CPUTF8;)V
    .locals 4
    .param p1, "utf8"    # Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 28
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/CPConstant;-><init>()V

    .line 29
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->utf8:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 30
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->getUnderlyingString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->className:Ljava/lang/String;

    .line 31
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->className:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    .line 32
    .local v0, "chars":[C
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    .line 33
    aget-char v2, v0, v1

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_0

    .line 34
    const/4 v2, 0x1

    iput-boolean v2, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->isInnerClass:Z

    .line 35
    return-void

    .line 32
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 38
    .end local v1    # "i":I
    :cond_1
    const/4 v1, 0x0

    iput-boolean v1, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->isInnerClass:Z

    .line 39
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 2
    .param p1, "arg0"    # Ljava/lang/Object;

    .line 43
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->className:Ljava/lang/String;

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPClass;

    iget-object v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPClass;->className:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getIndexInCpUtf8()I
    .locals 1

    .line 52
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->utf8:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->getIndex()I

    move-result v0

    return v0
.end method

.method public isInnerClass()Z
    .locals 1

    .line 56
    iget-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->isInnerClass:Z

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPClass;->className:Ljava/lang/String;

    return-object v0
.end method
