.class public Lorg/apache/commons/compress/harmony/pack200/CPSignature;
.super Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;
.source "CPSignature.java"

# interfaces
.implements Ljava/lang/Comparable;


# instance fields
.field private final classes:Ljava/util/List;

.field private final formStartsWithBracket:Z

.field private final signature:Ljava/lang/String;

.field private final signatureForm:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lorg/apache/commons/compress/harmony/pack200/CPUTF8;Ljava/util/List;)V
    .locals 2
    .param p1, "signature"    # Ljava/lang/String;
    .param p2, "signatureForm"    # Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .param p3, "classes"    # Ljava/util/List;

    .line 31
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;-><init>()V

    .line 32
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    .line 33
    iput-object p2, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signatureForm:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 34
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    .line 35
    invoke-virtual {p2}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->formStartsWithBracket:Z

    .line 36
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 4
    .param p1, "arg0"    # Ljava/lang/Object;

    .line 40
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-object v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 41
    const/4 v0, 0x0

    return v0

    .line 43
    :cond_0
    iget-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->formStartsWithBracket:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    move-object v0, p1

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-boolean v0, v0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->formStartsWithBracket:Z

    if-nez v0, :cond_1

    .line 44
    return v1

    .line 46
    :cond_1
    move-object v0, p1

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-boolean v0, v0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->formStartsWithBracket:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->formStartsWithBracket:Z

    if-nez v0, :cond_2

    .line 47
    const/4 v0, -0x1

    return v0

    .line 49
    :cond_2
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    move-object v2, p1

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-object v2, v2, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    sub-int/2addr v0, v2

    if-eqz v0, :cond_3

    .line 50
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-object v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int/2addr v0, v1

    return v0

    .line 52
    :cond_3
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_5

    .line 53
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    sub-int/2addr v0, v1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_5

    .line 54
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPClass;

    .line 55
    .local v1, "cpClass":Lorg/apache/commons/compress/harmony/pack200/CPClass;
    move-object v2, p1

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-object v2, v2, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/CPClass;

    .line 56
    .local v2, "compareClass":Lorg/apache/commons/compress/harmony/pack200/CPClass;
    invoke-virtual {v1, v2}, Lorg/apache/commons/compress/harmony/pack200/CPClass;->compareTo(Ljava/lang/Object;)I

    move-result v3

    .line 57
    .local v3, "classComp":I
    if-eqz v3, :cond_4

    .line 58
    return v3

    .line 53
    .end local v1    # "cpClass":Lorg/apache/commons/compress/harmony/pack200/CPClass;
    .end local v2    # "compareClass":Lorg/apache/commons/compress/harmony/pack200/CPClass;
    .end local v3    # "classComp":I
    :cond_4
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 62
    .end local v0    # "i":I
    :cond_5
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPSignature;

    iget-object v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getClasses()Ljava/util/List;
    .locals 1

    .line 70
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->classes:Ljava/util/List;

    return-object v0
.end method

.method public getIndexInCpUtf8()I
    .locals 1

    .line 66
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signatureForm:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->getIndex()I

    move-result v0

    return v0
.end method

.method public getSignatureForm()Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .locals 1

    .line 83
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signatureForm:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    return-object v0
.end method

.method public getUnderlyingString()Ljava/lang/String;
    .locals 1

    .line 79
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 75
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPSignature;->signature:Ljava/lang/String;

    return-object v0
.end method
