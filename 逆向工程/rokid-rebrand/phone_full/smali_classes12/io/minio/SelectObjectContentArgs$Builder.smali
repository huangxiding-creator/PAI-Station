.class public final Lio/minio/SelectObjectContentArgs$Builder;
.super Lio/minio/ObjectReadArgs$Builder;
.source "SelectObjectContentArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SelectObjectContentArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectReadArgs$Builder<",
        "Lio/minio/SelectObjectContentArgs$Builder;",
        "Lio/minio/SelectObjectContentArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 66
    invoke-direct {p0}, Lio/minio/ObjectReadArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$inputSerialization$1(Lio/minio/messages/InputSerialization;Lio/minio/SelectObjectContentArgs;)V
    .locals 0
    .param p0, "inputSerialization"    # Lio/minio/messages/InputSerialization;
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 84
    invoke-static {p1, p0}, Lio/minio/SelectObjectContentArgs;->access$402(Lio/minio/SelectObjectContentArgs;Lio/minio/messages/InputSerialization;)Lio/minio/messages/InputSerialization;

    return-void
.end method

.method static synthetic lambda$outputSerialization$2(Lio/minio/messages/OutputSerialization;Lio/minio/SelectObjectContentArgs;)V
    .locals 0
    .param p0, "outputSerialization"    # Lio/minio/messages/OutputSerialization;
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 94
    invoke-static {p1, p0}, Lio/minio/SelectObjectContentArgs;->access$302(Lio/minio/SelectObjectContentArgs;Lio/minio/messages/OutputSerialization;)Lio/minio/messages/OutputSerialization;

    return-void
.end method

.method static synthetic lambda$requestProgress$3(Ljava/lang/Boolean;Lio/minio/SelectObjectContentArgs;)V
    .locals 0
    .param p0, "requestProgress"    # Ljava/lang/Boolean;
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 99
    invoke-static {p1, p0}, Lio/minio/SelectObjectContentArgs;->access$202(Lio/minio/SelectObjectContentArgs;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    return-void
.end method

.method static synthetic lambda$scanEndRange$5(Ljava/lang/Long;Lio/minio/SelectObjectContentArgs;)V
    .locals 0
    .param p0, "scanEndRange"    # Ljava/lang/Long;
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 109
    invoke-static {p1, p0}, Lio/minio/SelectObjectContentArgs;->access$002(Lio/minio/SelectObjectContentArgs;Ljava/lang/Long;)Ljava/lang/Long;

    return-void
.end method

.method static synthetic lambda$scanStartRange$4(Ljava/lang/Long;Lio/minio/SelectObjectContentArgs;)V
    .locals 0
    .param p0, "scanStartRange"    # Ljava/lang/Long;
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 104
    invoke-static {p1, p0}, Lio/minio/SelectObjectContentArgs;->access$102(Lio/minio/SelectObjectContentArgs;Ljava/lang/Long;)Ljava/lang/Long;

    return-void
.end method

.method static synthetic lambda$sqlExpression$0(Ljava/lang/String;Lio/minio/SelectObjectContentArgs;)V
    .locals 0
    .param p0, "sqlExpression"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 74
    invoke-static {p1, p0}, Lio/minio/SelectObjectContentArgs;->access$502(Lio/minio/SelectObjectContentArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method private validateInputSerialization(Lio/minio/messages/InputSerialization;)V
    .locals 1
    .param p1, "is"    # Lio/minio/messages/InputSerialization;

    .line 79
    const-string v0, "inputSerialization"

    invoke-virtual {p0, p1, v0}, Lio/minio/SelectObjectContentArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 80
    return-void
.end method

.method private validateOutputSerialization(Lio/minio/messages/OutputSerialization;)V
    .locals 1
    .param p1, "os"    # Lio/minio/messages/OutputSerialization;

    .line 89
    const-string v0, "outputSerialization"

    invoke-virtual {p0, p1, v0}, Lio/minio/SelectObjectContentArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 90
    return-void
.end method

.method private validateSqlExpression(Ljava/lang/String;)V
    .locals 1
    .param p1, "se"    # Ljava/lang/String;

    .line 69
    const-string/jumbo v0, "sqlExpression"

    invoke-virtual {p0, p1, v0}, Lio/minio/SelectObjectContentArgs$Builder;->validateNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    return-void
.end method


# virtual methods
.method public inputSerialization(Lio/minio/messages/InputSerialization;)Lio/minio/SelectObjectContentArgs$Builder;
    .locals 2
    .param p1, "inputSerialization"    # Lio/minio/messages/InputSerialization;

    .line 83
    invoke-direct {p0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->validateInputSerialization(Lio/minio/messages/InputSerialization;)V

    .line 84
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda5;

    invoke-direct {v1, p1}, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda5;-><init>(Lio/minio/messages/InputSerialization;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 85
    return-object p0
.end method

.method public outputSerialization(Lio/minio/messages/OutputSerialization;)Lio/minio/SelectObjectContentArgs$Builder;
    .locals 2
    .param p1, "outputSerialization"    # Lio/minio/messages/OutputSerialization;

    .line 93
    invoke-direct {p0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->validateOutputSerialization(Lio/minio/messages/OutputSerialization;)V

    .line 94
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1}, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda2;-><init>(Lio/minio/messages/OutputSerialization;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 95
    return-object p0
.end method

.method public requestProgress(Ljava/lang/Boolean;)Lio/minio/SelectObjectContentArgs$Builder;
    .locals 2
    .param p1, "requestProgress"    # Ljava/lang/Boolean;

    .line 99
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda3;

    invoke-direct {v1, p1}, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda3;-><init>(Ljava/lang/Boolean;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 100
    return-object p0
.end method

.method public scanEndRange(Ljava/lang/Long;)Lio/minio/SelectObjectContentArgs$Builder;
    .locals 2
    .param p1, "scanEndRange"    # Ljava/lang/Long;

    .line 109
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/Long;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 110
    return-object p0
.end method

.method public scanStartRange(Ljava/lang/Long;)Lio/minio/SelectObjectContentArgs$Builder;
    .locals 2
    .param p1, "scanStartRange"    # Ljava/lang/Long;

    .line 104
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/Long;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 105
    return-object p0
.end method

.method public sqlExpression(Ljava/lang/String;)Lio/minio/SelectObjectContentArgs$Builder;
    .locals 2
    .param p1, "sqlExpression"    # Ljava/lang/String;

    .line 73
    invoke-direct {p0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->validateSqlExpression(Ljava/lang/String;)V

    .line 74
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1}, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda4;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 75
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 66
    check-cast p1, Lio/minio/SelectObjectContentArgs;

    invoke-virtual {p0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->validate(Lio/minio/SelectObjectContentArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 66
    check-cast p1, Lio/minio/SelectObjectContentArgs;

    invoke-virtual {p0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->validate(Lio/minio/SelectObjectContentArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 66
    check-cast p1, Lio/minio/SelectObjectContentArgs;

    invoke-virtual {p0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->validate(Lio/minio/SelectObjectContentArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SelectObjectContentArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;

    .line 115
    invoke-super {p0, p1}, Lio/minio/ObjectReadArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 116
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->sqlExpression()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SelectObjectContentArgs$Builder;->validateSqlExpression(Ljava/lang/String;)V

    .line 117
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->inputSerialization()Lio/minio/messages/InputSerialization;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SelectObjectContentArgs$Builder;->validateInputSerialization(Lio/minio/messages/InputSerialization;)V

    .line 118
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->outputSerialization()Lio/minio/messages/OutputSerialization;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SelectObjectContentArgs$Builder;->validateOutputSerialization(Lio/minio/messages/OutputSerialization;)V

    .line 119
    return-void
.end method
