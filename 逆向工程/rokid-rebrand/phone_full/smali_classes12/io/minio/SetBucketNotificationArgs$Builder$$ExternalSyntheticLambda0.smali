.class public final synthetic Lio/minio/SetBucketNotificationArgs$Builder$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/messages/NotificationConfiguration;


# direct methods
.method public synthetic constructor <init>(Lio/minio/messages/NotificationConfiguration;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/SetBucketNotificationArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/messages/NotificationConfiguration;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/SetBucketNotificationArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/messages/NotificationConfiguration;

    check-cast p1, Lio/minio/SetBucketNotificationArgs;

    invoke-static {v0, p1}, Lio/minio/SetBucketNotificationArgs$Builder;->lambda$config$0(Lio/minio/messages/NotificationConfiguration;Lio/minio/SetBucketNotificationArgs;)V

    return-void
.end method
