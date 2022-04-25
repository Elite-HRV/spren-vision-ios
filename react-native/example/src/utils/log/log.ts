import * as Sentry from '@sentry/browser';

enum EFeature1Context {
    RESULT_CONTEXT_1 = 'RESULT_CONTEXT_1',
}

// enum EFeature2Context {
//     EXAMPLE_CONTEXT_3 = 'EXAMPLE_CONTEXT_3',
// }

export const contextNames = {
    ...EFeature1Context,
    // ...EFeature2Context,
};

export type TContextName = keyof typeof contextNames;
export type TFeatureName = 'processing' | 'result';

export const logLevel = Sentry.Severity;

export default function log(
    featureName: TFeatureName,
    errorMessage: string,
    contextName: TContextName,
    properties: object,
    level: Sentry.Severity = Sentry.Severity.Error,
) {
    Sentry.setContext(contextName, properties);

    Sentry.withScope((scope) => {
        scope.setTag('feature', featureName);
        scope.setLevel(level);
        Sentry.captureException(new Error(errorMessage));
    });
}
