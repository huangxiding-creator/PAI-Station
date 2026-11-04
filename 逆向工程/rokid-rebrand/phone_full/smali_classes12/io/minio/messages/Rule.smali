.class public Lio/minio/messages/Rule;
.super Ljava/lang/Object;
.source "Rule.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Rule"
    strict = false
.end annotation


# instance fields
.field private duration:Lio/minio/messages/RetentionDuration;
    .annotation runtime Lorg/simpleframework/xml/ElementUnion;
        value = {
            .subannotation Lorg/simpleframework/xml/Element;
                name = "Days"
                required = false
                type = Lio/minio/messages/RetentionDurationDays;
            .end subannotation,
            .subannotation Lorg/simpleframework/xml/Element;
                name = "Years"
                required = false
                type = Lio/minio/messages/RetentionDurationYears;
            .end subannotation
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "DefaultRetention"
    .end annotation
.end field

.field private mode:Lio/minio/messages/RetentionMode;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Mode"
        required = false
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "DefaultRetention"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/RetentionMode;Lio/minio/messages/RetentionDuration;)V
    .locals 2
    .param p1, "mode"    # Lio/minio/messages/RetentionMode;
        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Mode"
            required = false
        .end annotation
    .end param
    .param p2, "duration"    # Lio/minio/messages/RetentionDuration;
        .annotation runtime Lorg/simpleframework/xml/ElementUnion;
            value = {
                .subannotation Lorg/simpleframework/xml/Element;
                    name = "Days"
                    required = false
                    type = Lio/minio/messages/RetentionDurationDays;
                .end subannotation,
                .subannotation Lorg/simpleframework/xml/Element;
                    name = "Years"
                    required = false
                    type = Lio/minio/messages/RetentionDurationYears;
                .end subannotation
            }
        .end annotation
    .end param

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    .line 46
    iput-object p1, p0, Lio/minio/messages/Rule;->mode:Lio/minio/messages/RetentionMode;

    .line 47
    iput-object p2, p0, Lio/minio/messages/Rule;->duration:Lio/minio/messages/RetentionDuration;

    goto :goto_0

    .line 48
    :cond_0
    if-nez p1, :cond_2

    if-eqz p2, :cond_1

    goto :goto_1

    .line 54
    :cond_1
    :goto_0
    return-void

    .line 49
    :cond_2
    :goto_1
    if-nez p1, :cond_3

    .line 50
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "mode is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 52
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "duration is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public duration()Lio/minio/messages/RetentionDuration;
    .locals 1

    .line 61
    iget-object v0, p0, Lio/minio/messages/Rule;->duration:Lio/minio/messages/RetentionDuration;

    return-object v0
.end method

.method public mode()Lio/minio/messages/RetentionMode;
    .locals 1

    .line 57
    iget-object v0, p0, Lio/minio/messages/Rule;->mode:Lio/minio/messages/RetentionMode;

    return-object v0
.end method
