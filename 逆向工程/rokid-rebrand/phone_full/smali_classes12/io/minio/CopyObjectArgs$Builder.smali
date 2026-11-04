.class public final Lio/minio/CopyObjectArgs$Builder;
.super Lio/minio/ObjectWriteArgs$Builder;
.source "CopyObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/CopyObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectWriteArgs$Builder<",
        "Lio/minio/CopyObjectArgs$Builder;",
        "Lio/minio/CopyObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 69
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$metadataDirective$1(Lio/minio/Directive;Lio/minio/CopyObjectArgs;)V
    .locals 0
    .param p0, "directive"    # Lio/minio/Directive;
    .param p1, "args"    # Lio/minio/CopyObjectArgs;

    .line 93
    invoke-static {p1, p0}, Lio/minio/CopyObjectArgs;->access$102(Lio/minio/CopyObjectArgs;Lio/minio/Directive;)Lio/minio/Directive;

    return-void
.end method

.method static synthetic lambda$source$0(Lio/minio/CopySource;Lio/minio/CopyObjectArgs;)V
    .locals 0
    .param p0, "source"    # Lio/minio/CopySource;
    .param p1, "args"    # Lio/minio/CopyObjectArgs;

    .line 88
    invoke-static {p1, p0}, Lio/minio/CopyObjectArgs;->access$002(Lio/minio/CopyObjectArgs;Lio/minio/CopySource;)Lio/minio/CopySource;

    return-void
.end method

.method static synthetic lambda$taggingDirective$2(Lio/minio/Directive;Lio/minio/CopyObjectArgs;)V
    .locals 0
    .param p0, "directive"    # Lio/minio/Directive;
    .param p1, "args"    # Lio/minio/CopyObjectArgs;

    .line 98
    invoke-static {p1, p0}, Lio/minio/CopyObjectArgs;->access$202(Lio/minio/CopyObjectArgs;Lio/minio/Directive;)Lio/minio/Directive;

    return-void
.end method


# virtual methods
.method public metadataDirective(Lio/minio/Directive;)Lio/minio/CopyObjectArgs$Builder;
    .locals 2
    .param p1, "directive"    # Lio/minio/Directive;

    .line 93
    iget-object v0, p0, Lio/minio/CopyObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/Directive;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 94
    return-object p0
.end method

.method public source(Lio/minio/CopySource;)Lio/minio/CopyObjectArgs$Builder;
    .locals 2
    .param p1, "source"    # Lio/minio/CopySource;

    .line 87
    const-string v0, "copy source"

    invoke-virtual {p0, p1, v0}, Lio/minio/CopyObjectArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 88
    iget-object v0, p0, Lio/minio/CopyObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda1;-><init>(Lio/minio/CopySource;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 89
    return-object p0
.end method

.method public taggingDirective(Lio/minio/Directive;)Lio/minio/CopyObjectArgs$Builder;
    .locals 2
    .param p1, "directive"    # Lio/minio/Directive;

    .line 98
    iget-object v0, p0, Lio/minio/CopyObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1}, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda2;-><init>(Lio/minio/Directive;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 99
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 69
    check-cast p1, Lio/minio/CopyObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/CopyObjectArgs$Builder;->validate(Lio/minio/CopyObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 69
    check-cast p1, Lio/minio/CopyObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/CopyObjectArgs$Builder;->validate(Lio/minio/CopyObjectArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/CopyObjectArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/CopyObjectArgs;

    .line 72
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 73
    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$000(Lio/minio/CopyObjectArgs;)Lio/minio/CopySource;

    move-result-object v0

    const-string v1, "copy source"

    invoke-virtual {p0, v0, v1}, Lio/minio/CopyObjectArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 74
    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$000(Lio/minio/CopyObjectArgs;)Lio/minio/CopySource;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/CopySource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$000(Lio/minio/CopyObjectArgs;)Lio/minio/CopySource;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/CopySource;->length()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 75
    :cond_0
    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$100(Lio/minio/CopyObjectArgs;)Lio/minio/Directive;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$100(Lio/minio/CopyObjectArgs;)Lio/minio/Directive;

    move-result-object v0

    sget-object v1, Lio/minio/Directive;->COPY:Lio/minio/Directive;

    if-eq v0, v1, :cond_1

    goto :goto_0

    .line 76
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "COPY metadata directive is not applicable to source object with range"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 79
    :cond_2
    :goto_0
    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$200(Lio/minio/CopyObjectArgs;)Lio/minio/Directive;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-static {p1}, Lio/minio/CopyObjectArgs;->access$200(Lio/minio/CopyObjectArgs;)Lio/minio/Directive;

    move-result-object v0

    sget-object v1, Lio/minio/Directive;->COPY:Lio/minio/Directive;

    if-eq v0, v1, :cond_3

    goto :goto_1

    .line 80
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "COPY tagging directive is not applicable to source object with range"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 84
    :cond_4
    :goto_1
    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 69
    check-cast p1, Lio/minio/CopyObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/CopyObjectArgs$Builder;->validate(Lio/minio/CopyObjectArgs;)V

    return-void
.end method
