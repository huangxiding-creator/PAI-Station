.class public final Lio/minio/SetObjectTagsArgs$Builder;
.super Lio/minio/ObjectVersionArgs$Builder;
.source "SetObjectTagsArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetObjectTagsArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectVersionArgs$Builder<",
        "Lio/minio/SetObjectTagsArgs$Builder;",
        "Lio/minio/SetObjectTagsArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$tags$0(Ljava/util/Map;Lio/minio/SetObjectTagsArgs;)V
    .locals 1
    .param p0, "map"    # Ljava/util/Map;
    .param p1, "args"    # Lio/minio/SetObjectTagsArgs;

    .line 50
    invoke-static {p0}, Lio/minio/messages/Tags;->newObjectTags(Ljava/util/Map;)Lio/minio/messages/Tags;

    move-result-object v0

    invoke-static {p1, v0}, Lio/minio/SetObjectTagsArgs;->access$002(Lio/minio/SetObjectTagsArgs;Lio/minio/messages/Tags;)Lio/minio/messages/Tags;

    return-void
.end method

.method static synthetic lambda$tags$1(Lio/minio/messages/Tags;Lio/minio/SetObjectTagsArgs;)V
    .locals 0
    .param p0, "tags"    # Lio/minio/messages/Tags;
    .param p1, "args"    # Lio/minio/SetObjectTagsArgs;

    .line 56
    invoke-static {p1, p0}, Lio/minio/SetObjectTagsArgs;->access$002(Lio/minio/SetObjectTagsArgs;Lio/minio/messages/Tags;)Lio/minio/messages/Tags;

    return-void
.end method

.method private validateTags(Lio/minio/messages/Tags;)V
    .locals 1
    .param p1, "tags"    # Lio/minio/messages/Tags;

    .line 40
    const-string/jumbo v0, "tags"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetObjectTagsArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    return-void
.end method


# virtual methods
.method public tags(Lio/minio/messages/Tags;)Lio/minio/SetObjectTagsArgs$Builder;
    .locals 2
    .param p1, "tags"    # Lio/minio/messages/Tags;

    .line 55
    invoke-direct {p0, p1}, Lio/minio/SetObjectTagsArgs$Builder;->validateTags(Lio/minio/messages/Tags;)V

    .line 56
    iget-object v0, p0, Lio/minio/SetObjectTagsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/Tags;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 57
    return-object p0
.end method

.method public tags(Ljava/util/Map;)Lio/minio/SetObjectTagsArgs$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lio/minio/SetObjectTagsArgs$Builder;"
        }
    .end annotation

    .line 49
    .local p1, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "map for tags"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetObjectTagsArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    iget-object v0, p0, Lio/minio/SetObjectTagsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/util/Map;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 51
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 38
    check-cast p1, Lio/minio/SetObjectTagsArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectTagsArgs$Builder;->validate(Lio/minio/SetObjectTagsArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 38
    check-cast p1, Lio/minio/SetObjectTagsArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectTagsArgs$Builder;->validate(Lio/minio/SetObjectTagsArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 38
    check-cast p1, Lio/minio/SetObjectTagsArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectTagsArgs$Builder;->validate(Lio/minio/SetObjectTagsArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetObjectTagsArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetObjectTagsArgs;

    .line 44
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 45
    invoke-static {p1}, Lio/minio/SetObjectTagsArgs;->access$000(Lio/minio/SetObjectTagsArgs;)Lio/minio/messages/Tags;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetObjectTagsArgs$Builder;->validateTags(Lio/minio/messages/Tags;)V

    .line 46
    return-void
.end method
