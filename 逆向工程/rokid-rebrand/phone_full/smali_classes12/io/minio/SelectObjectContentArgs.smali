.class public Lio/minio/SelectObjectContentArgs;
.super Lio/minio/ObjectReadArgs;
.source "SelectObjectContentArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/SelectObjectContentArgs$Builder;
    }
.end annotation


# instance fields
.field private inputSerialization:Lio/minio/messages/InputSerialization;

.field private outputSerialization:Lio/minio/messages/OutputSerialization;

.field private requestProgress:Ljava/lang/Boolean;

.field private scanEndRange:Ljava/lang/Long;

.field private scanStartRange:Ljava/lang/Long;

.field private sqlExpression:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Lio/minio/ObjectReadArgs;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lio/minio/SelectObjectContentArgs;Ljava/lang/Long;)Ljava/lang/Long;
    .locals 0
    .param p0, "x0"    # Lio/minio/SelectObjectContentArgs;
    .param p1, "x1"    # Ljava/lang/Long;

    .line 29
    iput-object p1, p0, Lio/minio/SelectObjectContentArgs;->scanEndRange:Ljava/lang/Long;

    return-object p1
.end method

.method static synthetic access$102(Lio/minio/SelectObjectContentArgs;Ljava/lang/Long;)Ljava/lang/Long;
    .locals 0
    .param p0, "x0"    # Lio/minio/SelectObjectContentArgs;
    .param p1, "x1"    # Ljava/lang/Long;

    .line 29
    iput-object p1, p0, Lio/minio/SelectObjectContentArgs;->scanStartRange:Ljava/lang/Long;

    return-object p1
.end method

.method static synthetic access$202(Lio/minio/SelectObjectContentArgs;Ljava/lang/Boolean;)Ljava/lang/Boolean;
    .locals 0
    .param p0, "x0"    # Lio/minio/SelectObjectContentArgs;
    .param p1, "x1"    # Ljava/lang/Boolean;

    .line 29
    iput-object p1, p0, Lio/minio/SelectObjectContentArgs;->requestProgress:Ljava/lang/Boolean;

    return-object p1
.end method

.method static synthetic access$302(Lio/minio/SelectObjectContentArgs;Lio/minio/messages/OutputSerialization;)Lio/minio/messages/OutputSerialization;
    .locals 0
    .param p0, "x0"    # Lio/minio/SelectObjectContentArgs;
    .param p1, "x1"    # Lio/minio/messages/OutputSerialization;

    .line 29
    iput-object p1, p0, Lio/minio/SelectObjectContentArgs;->outputSerialization:Lio/minio/messages/OutputSerialization;

    return-object p1
.end method

.method static synthetic access$402(Lio/minio/SelectObjectContentArgs;Lio/minio/messages/InputSerialization;)Lio/minio/messages/InputSerialization;
    .locals 0
    .param p0, "x0"    # Lio/minio/SelectObjectContentArgs;
    .param p1, "x1"    # Lio/minio/messages/InputSerialization;

    .line 29
    iput-object p1, p0, Lio/minio/SelectObjectContentArgs;->inputSerialization:Lio/minio/messages/InputSerialization;

    return-object p1
.end method

.method static synthetic access$502(Lio/minio/SelectObjectContentArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/SelectObjectContentArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 29
    iput-object p1, p0, Lio/minio/SelectObjectContentArgs;->sqlExpression:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/SelectObjectContentArgs$Builder;
    .locals 1

    .line 62
    new-instance v0, Lio/minio/SelectObjectContentArgs$Builder;

    invoke-direct {v0}, Lio/minio/SelectObjectContentArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 124
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 125
    :cond_0
    instance-of v1, p1, Lio/minio/SelectObjectContentArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 126
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectReadArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 127
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/SelectObjectContentArgs;

    .line 128
    .local v1, "that":Lio/minio/SelectObjectContentArgs;
    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->sqlExpression:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/SelectObjectContentArgs;->sqlExpression:Ljava/lang/String;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->inputSerialization:Lio/minio/messages/InputSerialization;

    iget-object v4, v1, Lio/minio/SelectObjectContentArgs;->inputSerialization:Lio/minio/messages/InputSerialization;

    .line 129
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->outputSerialization:Lio/minio/messages/OutputSerialization;

    iget-object v4, v1, Lio/minio/SelectObjectContentArgs;->outputSerialization:Lio/minio/messages/OutputSerialization;

    .line 130
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->requestProgress:Ljava/lang/Boolean;

    iget-object v4, v1, Lio/minio/SelectObjectContentArgs;->requestProgress:Ljava/lang/Boolean;

    .line 131
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->scanStartRange:Ljava/lang/Long;

    iget-object v4, v1, Lio/minio/SelectObjectContentArgs;->scanStartRange:Ljava/lang/Long;

    .line 132
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->scanEndRange:Ljava/lang/Long;

    iget-object v4, v1, Lio/minio/SelectObjectContentArgs;->scanEndRange:Ljava/lang/Long;

    .line 133
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 128
    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 8

    .line 138
    nop

    .line 139
    invoke-super {p0}, Lio/minio/ObjectReadArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p0, Lio/minio/SelectObjectContentArgs;->sqlExpression:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/SelectObjectContentArgs;->inputSerialization:Lio/minio/messages/InputSerialization;

    iget-object v4, p0, Lio/minio/SelectObjectContentArgs;->outputSerialization:Lio/minio/messages/OutputSerialization;

    iget-object v5, p0, Lio/minio/SelectObjectContentArgs;->requestProgress:Ljava/lang/Boolean;

    iget-object v6, p0, Lio/minio/SelectObjectContentArgs;->scanStartRange:Ljava/lang/Long;

    iget-object v7, p0, Lio/minio/SelectObjectContentArgs;->scanEndRange:Ljava/lang/Long;

    filled-new-array/range {v1 .. v7}, [Ljava/lang/Object;

    move-result-object v0

    .line 138
    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public inputSerialization()Lio/minio/messages/InputSerialization;
    .locals 1

    .line 54
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs;->inputSerialization:Lio/minio/messages/InputSerialization;

    return-object v0
.end method

.method public outputSerialization()Lio/minio/messages/OutputSerialization;
    .locals 1

    .line 50
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs;->outputSerialization:Lio/minio/messages/OutputSerialization;

    return-object v0
.end method

.method public requestProgress()Ljava/lang/Boolean;
    .locals 1

    .line 46
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs;->requestProgress:Ljava/lang/Boolean;

    return-object v0
.end method

.method public scanEndRange()Ljava/lang/Long;
    .locals 1

    .line 38
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs;->scanEndRange:Ljava/lang/Long;

    return-object v0
.end method

.method public scanStartRange()Ljava/lang/Long;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs;->scanStartRange:Ljava/lang/Long;

    return-object v0
.end method

.method public sqlExpression()Ljava/lang/String;
    .locals 1

    .line 58
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs;->sqlExpression:Ljava/lang/String;

    return-object v0
.end method
