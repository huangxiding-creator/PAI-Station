.class public Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;
.super Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;
.source "CPNameAndType.java"

# interfaces
.implements Ljava/lang/Comparable;


# instance fields
.field private final name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

.field private final signature:Lorg/apache/commons/compress/harmony/pack200/CPSignature;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/pack200/CPUTF8;Lorg/apache/commons/compress/harmony/pack200/CPSignature;)V
    .locals 0
    .param p1, "name"    # Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .param p2, "signature"    # Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    .line 27
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;-><init>()V

    .line 28
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 29
    iput-object p2, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->signature:Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    .line 30
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 4
    .param p1, "obj"    # Ljava/lang/Object;

    .line 39
    instance-of v0, p1, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;

    if-eqz v0, :cond_1

    .line 40
    move-object v0, p1

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;

    .line 41
    .local v0, "nat":Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->signature:Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->signature:Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    invoke-virtual {v1, v2}, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->compareTo(Ljava/lang/Object;)I

    move-result v1

    .line 42
    .local v1, "compareSignature":I
    if-nez v1, :cond_0

    .line 43
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    iget-object v3, v0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v2, v3}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->compareTo(Ljava/lang/Object;)I

    move-result v2

    return v2

    .line 45
    :cond_0
    return v1

    .line 47
    .end local v0    # "nat":Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;
    .end local v1    # "compareSignature":I
    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 55
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->getUnderlyingString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNameIndex()I
    .locals 1

    .line 51
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->getIndex()I

    move-result v0

    return v0
.end method

.method public getTypeIndex()I
    .locals 1

    .line 59
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->signature:Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->getIndex()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 34
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/CPNameAndType;->signature:Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
