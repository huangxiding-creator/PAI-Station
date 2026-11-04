.class public final Lio/minio/SetBucketTagsArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "SetBucketTagsArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetBucketTagsArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/SetBucketTagsArgs$Builder;",
        "Lio/minio/SetBucketTagsArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 39
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$tags$0(Ljava/util/Map;Lio/minio/SetBucketTagsArgs;)V
    .locals 1
    .param p0, "map"    # Ljava/util/Map;
    .param p1, "args"    # Lio/minio/SetBucketTagsArgs;

    .line 51
    invoke-static {p0}, Lio/minio/messages/Tags;->newBucketTags(Ljava/util/Map;)Lio/minio/messages/Tags;

    move-result-object v0

    invoke-static {p1, v0}, Lio/minio/SetBucketTagsArgs;->access$002(Lio/minio/SetBucketTagsArgs;Lio/minio/messages/Tags;)Lio/minio/messages/Tags;

    return-void
.end method

.method static synthetic lambda$tags$1(Lio/minio/messages/Tags;Lio/minio/SetBucketTagsArgs;)V
    .locals 0
    .param p0, "tags"    # Lio/minio/messages/Tags;
    .param p1, "args"    # Lio/minio/SetBucketTagsArgs;

    .line 57
    invoke-static {p1, p0}, Lio/minio/SetBucketTagsArgs;->access$002(Lio/minio/SetBucketTagsArgs;Lio/minio/messages/Tags;)Lio/minio/messages/Tags;

    return-void
.end method

.method private validateTags(Lio/minio/messages/Tags;)V
    .locals 1
    .param p1, "tags"    # Lio/minio/messages/Tags;

    .line 41
    const-string/jumbo v0, "tags"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketTagsArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    return-void
.end method


# virtual methods
.method public tags(Lio/minio/messages/Tags;)Lio/minio/SetBucketTagsArgs$Builder;
    .locals 2
    .param p1, "tags"    # Lio/minio/messages/Tags;

    .line 56
    invoke-direct {p0, p1}, Lio/minio/SetBucketTagsArgs$Builder;->validateTags(Lio/minio/messages/Tags;)V

    .line 57
    iget-object v0, p0, Lio/minio/SetBucketTagsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketTagsArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/SetBucketTagsArgs$Builder$$ExternalSyntheticLambda1;-><init>(Lio/minio/messages/Tags;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 58
    return-object p0
.end method

.method public tags(Ljava/util/Map;)Lio/minio/SetBucketTagsArgs$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lio/minio/SetBucketTagsArgs$Builder;"
        }
    .end annotation

    .line 50
    .local p1, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "map for tags"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketTagsArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    iget-object v0, p0, Lio/minio/SetBucketTagsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketTagsArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetBucketTagsArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/util/Map;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 52
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetBucketTagsArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketTagsArgs$Builder;->validate(Lio/minio/SetBucketTagsArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetBucketTagsArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketTagsArgs$Builder;->validate(Lio/minio/SetBucketTagsArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetBucketTagsArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetBucketTagsArgs;

    .line 45
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 46
    invoke-static {p1}, Lio/minio/SetBucketTagsArgs;->access$000(Lio/minio/SetBucketTagsArgs;)Lio/minio/messages/Tags;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetBucketTagsArgs$Builder;->validateTags(Lio/minio/messages/Tags;)V

    .line 47
    return-void
.end method
