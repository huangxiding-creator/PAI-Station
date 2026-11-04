.class public Lio/minio/messages/LifecycleRule;
.super Ljava/lang/Object;
.source "LifecycleRule.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Rule"
.end annotation


# instance fields
.field private abortIncompleteMultipartUpload:Lio/minio/messages/AbortIncompleteMultipartUpload;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "AbortIncompleteMultipartUpload"
        required = false
    .end annotation
.end field

.field private expiration:Lio/minio/messages/Expiration;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Expiration"
        required = false
    .end annotation
.end field

.field private filter:Lio/minio/messages/RuleFilter;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Filter"
        required = false
    .end annotation
.end field

.field private id:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ID"
        required = false
    .end annotation
.end field

.field private noncurrentVersionExpiration:Lio/minio/messages/NoncurrentVersionExpiration;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NoncurrentVersionExpiration"
        required = false
    .end annotation
.end field

.field private noncurrentVersionTransition:Lio/minio/messages/NoncurrentVersionTransition;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NoncurrentVersionTransition"
        required = false
    .end annotation
.end field

.field private status:Lio/minio/messages/Status;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
    .end annotation
.end field

.field private transition:Lio/minio/messages/Transition;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Transition"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/Status;Lio/minio/messages/AbortIncompleteMultipartUpload;Lio/minio/messages/Expiration;Lio/minio/messages/RuleFilter;Ljava/lang/String;Lio/minio/messages/NoncurrentVersionExpiration;Lio/minio/messages/NoncurrentVersionTransition;Lio/minio/messages/Transition;)V
    .locals 2
    .param p1, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
        .end annotation
    .end param
    .param p2, "abortIncompleteMultipartUpload"    # Lio/minio/messages/AbortIncompleteMultipartUpload;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "AbortIncompleteMultipartUpload"
            required = false
        .end annotation
    .end param
    .param p3, "expiration"    # Lio/minio/messages/Expiration;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Expiration"
            required = false
        .end annotation
    .end param
    .param p4, "filter"    # Lio/minio/messages/RuleFilter;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Filter"
            required = false
        .end annotation
    .end param
    .param p5, "id"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ID"
            required = false
        .end annotation
    .end param
    .param p6, "noncurrentVersionExpiration"    # Lio/minio/messages/NoncurrentVersionExpiration;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "NoncurrentVersionExpiration"
            required = false
        .end annotation
    .end param
    .param p7, "noncurrentVersionTransition"    # Lio/minio/messages/NoncurrentVersionTransition;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "NoncurrentVersionTransition"
            required = false
        .end annotation
    .end param
    .param p8, "transition"    # Lio/minio/messages/Transition;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Transition"
            required = false
        .end annotation
    .end param

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 67
    if-nez p2, :cond_1

    if-nez p3, :cond_1

    if-nez p6, :cond_1

    if-nez p7, :cond_1

    if-eqz p8, :cond_0

    goto :goto_0

    .line 72
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "At least one of action (AbortIncompleteMultipartUpload, Expiration, NoncurrentVersionExpiration, NoncurrentVersionTransition or Transition) must be specified in a rule"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 78
    :cond_1
    :goto_0
    if-eqz p5, :cond_4

    .line 79
    invoke-virtual {p5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p5

    .line 80
    invoke-virtual {p5}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 81
    invoke-virtual {p5}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xff

    if-gt v0, v1, :cond_2

    goto :goto_1

    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "ID must be exceed 255 characters"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 80
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "ID must be non-empty string"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 84
    :cond_4
    :goto_1
    iput-object p2, p0, Lio/minio/messages/LifecycleRule;->abortIncompleteMultipartUpload:Lio/minio/messages/AbortIncompleteMultipartUpload;

    .line 85
    iput-object p3, p0, Lio/minio/messages/LifecycleRule;->expiration:Lio/minio/messages/Expiration;

    .line 86
    const-string v0, "Filter must not be null"

    invoke-static {p4, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/RuleFilter;

    iput-object v0, p0, Lio/minio/messages/LifecycleRule;->filter:Lio/minio/messages/RuleFilter;

    .line 87
    iput-object p5, p0, Lio/minio/messages/LifecycleRule;->id:Ljava/lang/String;

    .line 88
    iput-object p6, p0, Lio/minio/messages/LifecycleRule;->noncurrentVersionExpiration:Lio/minio/messages/NoncurrentVersionExpiration;

    .line 89
    iput-object p7, p0, Lio/minio/messages/LifecycleRule;->noncurrentVersionTransition:Lio/minio/messages/NoncurrentVersionTransition;

    .line 90
    const-string v0, "Status must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Status;

    iput-object v0, p0, Lio/minio/messages/LifecycleRule;->status:Lio/minio/messages/Status;

    .line 91
    iput-object p8, p0, Lio/minio/messages/LifecycleRule;->transition:Lio/minio/messages/Transition;

    .line 92
    return-void
.end method


# virtual methods
.method public abortIncompleteMultipartUpload()Lio/minio/messages/AbortIncompleteMultipartUpload;
    .locals 1

    .line 95
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->abortIncompleteMultipartUpload:Lio/minio/messages/AbortIncompleteMultipartUpload;

    return-object v0
.end method

.method public expiration()Lio/minio/messages/Expiration;
    .locals 1

    .line 99
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->expiration:Lio/minio/messages/Expiration;

    return-object v0
.end method

.method public filter()Lio/minio/messages/RuleFilter;
    .locals 1

    .line 103
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->filter:Lio/minio/messages/RuleFilter;

    return-object v0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .line 107
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->id:Ljava/lang/String;

    return-object v0
.end method

.method public noncurrentVersionExpiration()Lio/minio/messages/NoncurrentVersionExpiration;
    .locals 1

    .line 111
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->noncurrentVersionExpiration:Lio/minio/messages/NoncurrentVersionExpiration;

    return-object v0
.end method

.method public noncurrentVersionTransition()Lio/minio/messages/NoncurrentVersionTransition;
    .locals 1

    .line 115
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->noncurrentVersionTransition:Lio/minio/messages/NoncurrentVersionTransition;

    return-object v0
.end method

.method public status()Lio/minio/messages/Status;
    .locals 1

    .line 119
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->status:Lio/minio/messages/Status;

    return-object v0
.end method

.method public transition()Lio/minio/messages/Transition;
    .locals 1

    .line 123
    iget-object v0, p0, Lio/minio/messages/LifecycleRule;->transition:Lio/minio/messages/Transition;

    return-object v0
.end method
