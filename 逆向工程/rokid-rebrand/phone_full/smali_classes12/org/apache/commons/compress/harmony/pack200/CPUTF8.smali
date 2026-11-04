.class public Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
.super Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;
.source "CPUTF8.java"

# interfaces
.implements Ljava/lang/Comparable;


# instance fields
.field private final string:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "string"    # Ljava/lang/String;

    .line 26
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;-><init>()V

    .line 27
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->string:Ljava/lang/String;

    .line 28
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 2
    .param p1, "arg0"    # Ljava/lang/Object;

    .line 32
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->string:Ljava/lang/String;

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    iget-object v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->string:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getUnderlyingString()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->string:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->string:Ljava/lang/String;

    return-object v0
.end method
